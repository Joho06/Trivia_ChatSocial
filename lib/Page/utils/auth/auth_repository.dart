import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Asegúrate de importar el paquete de Cloud Firestore
import 'package:firebase_database/firebase_database.dart'; // Asegúrate de importar el paquete de Firebase Database
import 'package:trivai_chat_social/Page/utils/auth/firebase_store.dart';
import '../../../Rutas/routes.dart';
import '../../../empty/userModel.dart';
import '../../utils/show_alert.dart';
import '../show_loading.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    realtime: FirebaseDatabase.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase realtime;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.realtime,
  });

  get mail => null;

  Stream<UserModel> getUserPresenceStatus({required String uid}) {
    return firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data()!));
  }

  void updateUserPresence() {
    Map<String, dynamic> online = {
      'active': true,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };
    Map<String, dynamic> offline = {
      'active': false,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };

    final connectedRef = realtime.ref('.info/connected');

    connectedRef.onValue.listen((event) async {
      final isConnected = event.snapshot.value as bool? ?? false;
      if (isConnected) {
        await realtime.ref().child(auth.currentUser!.uid).update(online);
      } else {
        realtime
            .ref()
            .child(auth.currentUser!.uid)
            .onDisconnect()
            .update(offline);
      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
    await firestore.collection('users').doc(auth.currentUser?.uid).get();

    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFirestore({
    required String username,
    required var profileImage,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Guardando información del usuario...",
      );
      String uid = auth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : '';
      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebase('profileImage/$uid', profileImage);
      }

      UserModel user = UserModel(
        username: username,
        mail: mail,
        uid: uid,
        profileImageUrl: profileImageUrl,
        active: true,
        lastSeen: DateTime.now().millisecondsSinceEpoch,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
            (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: 'Verificando codigo ... ',
      );
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode,
      );
      await auth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.userInfo,
            (route) => false,
        arguments: user?.profileImageUrl,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void sendSmsCode({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: "Enviando un código de verificación a $phoneNumber",
      );
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (smsCodeId, resendSmsCodeId) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.verification,
                (route) => false,
            arguments: {
              'phoneNumber': phoneNumber,
              'smsCodeId': smsCodeId,
            },
          );
        },
        codeAutoRetrievalTimeout: (String smsCodeId) {},
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }
}