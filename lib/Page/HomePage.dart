import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/chatScreen.dart';
import '../Screens/comunidadScreen.dart';
import '../Screens/statusScreen.dart';
import 'CameraPage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('TRIVAI APP',
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
            iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 0, right: 1),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraPage()),
                      );
                    },
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.search,
                    size: 28,
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              onSelected: (selected) {
                if (selected == 'Ajustes') {
                  Navigator.pushNamed(context, 'Ajustes');
                }
              },
              elevation: 10,
              padding: EdgeInsets.symmetric(vertical: 1),
              iconSize: 28,
              offset: Offset(0, 50),
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  value: 'Nuevo Grupo',
                  child: Text(
                    'Nuevo Grupo',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Vinculados',
                  child: Text(
                    'Vinculados',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: 'Ajustes',
                  child: Text(
                    'Ajustes',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ComunidadScreen(),
            StatusScreen(),
            ChatScreen(),
            //CallScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: BottomAppBar(
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(

              ),
              unselectedLabelStyle: Theme.of(context).textTheme.caption, // Establece el estilo de texto para las etiquetas no seleccionadas
              tabs: [
                Tab(
                  icon: Opacity(
                    opacity: _tabController.index == 2 ? 1.0 : 0.6,
                    child: Icon(Icons.groups_outlined, color: Theme.of(context).textTheme.caption!.color, size: 24), // Tamaño de icono ajustado a 24
                  ),
                  child: Text(
                    'Comunidad',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 14), // Tamaño de texto ajustado a 14
                  ),
                ),
                Tab(
                  icon: Opacity(
                    opacity: _tabController.index == 1 ? 1.0 : 0.6,
                    child: Icon(Icons.circle_notifications_outlined, color: Theme.of(context).textTheme.caption!.color, size: 24), // Tamaño de icono ajustado a 24
                  ),
                  child: Text(
                    'Historias',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 14), // Tamaño de texto ajustado a 14
                  ),
                ),

                Tab(
                  icon: Opacity(
                    opacity: _tabController.index == 0 ? 1.0 : 0.6,
                    child: Icon(Icons.chat_outlined, color: Theme.of(context).textTheme.caption!.color, size: 24), // Tamaño de icono ajustado a 24
                  ),
                  child: Text(
                    'IA',
                    style: TextStyle(color: Theme.of(context).textTheme.caption!.color, fontSize: 14), // Tamaño de texto ajustado a 14
                  ),
                ),
                /*Tab(
          icon: Opacity(
            opacity: _tabController.index == 3 ? 1.0 : 0.6,
            child: Icon(Icons.phone, color: Theme.of(context).textTheme.caption!.color, size: 20),
          ),
          child: Text(
            'Llamadas',
            style: TextStyle(color: Theme.of(context).textTheme.caption!.color),
          ),
        ),*/
              ],
            ),
          ),
        ),



        floatingActionButton: _tabController.index == 3
            ? floatingActionButton(Icon(Icons.message))
            : _tabController.index == 1
            ? floatingActionButtonEdit(
            Icon(Icons.edit), Icon(Icons.camera_alt))
            : _tabController.index == 3
            ? floatingActionButton(Icon(Icons.add_call))
            : Container());
  }

  Widget floatingActionButton(Icon icon) {
    return new FloatingActionButton(
      foregroundColor: Colors.white,
      backgroundColor: Color(0xFF075E55),
      child: icon,
      onPressed: () {},
    );
  }

  Widget floatingActionButtonEdit(Icon editIcon, Icon cameraIcon) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          foregroundColor: const Color(0xff49646c),
          backgroundColor: const Color(0xffebf4fc), // #128C7E
          child: editIcon,
          onPressed: () {
            // Lógica para el botón de editar
          },
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          child: cameraIcon,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPage()),
            );
          },
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
    );
  }
}



