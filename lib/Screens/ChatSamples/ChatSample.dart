import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';


class ChatSample extends StatelessWidget {

  List<String> mensjEnviado = [
    '¡Encantado! ¿Con quién tengo el gusto?',
    'Mucho gusto, Paul. ¿En qué puedo ayudarte?',
    'Claro, contamos con el siguiente paquete de viaje a México-Cancún:\nPaquete: Grand Oasis Cancún\nDuración: 4 días y 3 noches\nPrecio: \$450\nServicios: Traslado aeropuerto CUN – Hotel – aeropuerto CUN.\n- Participación en actividades y entretenimiento del hotel.\n- Sistema de alimentación todo incluido.\n- Habitación Gran Estándar.\n\n¿Te gustaría reservar este paquete o necesitas más información?',
    'Las fechas disponibles para el paquete Grand Oasis Cancún, México son: del 10 al 20 de agosto, del 20 al 31 de septiembre y del 5 al 15 de octubre. ¿Te gustaría reservar?',
    'Perfecto, ¿cuántas personas serán?',
    'El valor para la reserva del paquete Grand Oasis Cancún es de \$450. Confirma tu reserva, por favor proporcionándome los nombres de los pasajeros, un número de cédula y un correo electrónico.',
    'Gracias, el valor de tu reserva sería \$450. Tenemos diferentes formas de pago:\n1- Transferencia\n2- Pago con tarjeta de crédito (PayPhone)\nO puedes solicitar contactarte con uno de nuestros asesores especializados.',
    'Para finalizar el proceso, por favor haz clic en el siguiente enlace para proceder con el pago: https://www.payphone.app/.\n\nUna vez completado el pago, recibirás un correo electrónico con todos los detalles de tu pago.',
    'Por favor, envía una captura de pantalla del comprobante de pago.',
    'En este momento estamos verificando el pago...',
    'Tu pago se ha creditado correctamente. Recibirás un correo electrónico con más detalles de tu viaje.',
    'Gracias por preferirnos. ¡Buen viaje!',
  ];
  List<String> mensjRecivido = [
    'Hola, ayúdame con información',
    'Me llamo Paul',
    'Quiero viajar a México, ¿qué me recomendarías?',
    '¿Cuáles son las fechas disponibles para este paquete?',
    'Me gustaría reservar para el 10 al 15 de agosto',
    'Dos personas',
    'Paul Romero y Carla Garzon, CI: 1234567890, paulromero90@gmail.com',
    'Voy a realizar mi pago con una tarjeta de crédito',
    'En este momento ya realicé el pago',
    'Listo',
    'Gracias'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[0],
                  style: TextStyle(fontSize: 17,
                  color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[0],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[1],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[1],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[2],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[2],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[3],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[3],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[4],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[4],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[5],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[5],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[6],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[6],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[7],
                  style: TextStyle(fontSize: 17,
                      color: Colors.black,),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[7],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[8],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[8],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[9],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Image.asset(
                  'assets/images/mensaje.jpg', // Reemplaza con la ruta de tu imagen
                  width: 500, // ajusta el ancho de la imagen según tu necesidad
                  height: 500, // ajusta la altura de la imagen según tu necesidad
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[9],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[10],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 80),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.receive),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE4FDCA),
                ),
                child: Text(
                  mensjRecivido[10],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          margin: EdgeInsets.only(top: 20, left: 80, bottom: 15),
          child: Container(
            child: ClipPath(
              clipper: UpperNipMessageClipperTwo(MessageType.send),
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                ),
                child: Text(
                  mensjEnviado[11],
                  style: TextStyle(fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
