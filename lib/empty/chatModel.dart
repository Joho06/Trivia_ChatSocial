class chatClass{
  final String nombre;
  final String mensaje;
  final String hora;
  final String avatarUrl;
  final int newMensaje;

  chatClass(
      {required this.nombre, required this.mensaje, required this.hora, required this.avatarUrl, required this.newMensaje});
}
List<chatClass> temporalDate = [
  chatClass(
      nombre: "Rodrigo Lara",
      mensaje: "Mi hermano!, ¿Un partido hoy?",
      hora: "15:30",
      avatarUrl:
      "https://media-exp1.licdn.com/dms/image/C4E03AQFmcFwqwvJNMA/profile-displayphoto-shrink_200_200/0?e=1586995200&v=beta&t=4cwKRH-KwJGyOVUtu82PjVt9ss35d643fH-T7VFhxLQ", newMensaje: 1),
  chatClass(
      nombre: "Codigo Fuente",
      mensaje: "Hey! Tengo un nuevo video",
      hora: "17:30",
      avatarUrl:
      "https://yt3.ggpht.com/a-/AOh14Ggu5Wml45UPksoMVJq2rqctYSp_bLbg3U1zYmoO5g=s288-c-k-c0xffffffff-no-rj-mo", newMensaje: 1),
  chatClass(
      nombre: "Bill Gates",
      mensaje: "Windows 12 esta disponible!",
      hora: "5:00",
      avatarUrl:
      "https://mouse.latercera.com/wp-content/uploads/2018/05/bill.jpg", newMensaje: 0),
  chatClass(
      nombre: "Rachel",
      mensaje: "Estoy bien, gracias",
      hora: "10:30",
      avatarUrl:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWXUImijoB6F3msIRS96kTHW8YpthkyaONhzthSC4v7RYUzFya", newMensaje: 0),
  chatClass(
      nombre: "Barry Allen",
      mensaje: "Soy el hombre mas rapido",
      hora: "12:30",
      avatarUrl:
      "https://pbs.twimg.com/profile_images/1157751049928814592/5zHaCqeT_400x400.jpg", newMensaje: 0),
  chatClass(
      nombre: "Joe West",
      mensaje: "Te vi con Iris, le diré a Barry",
      hora: "18:30",
      avatarUrl:
      "https://elrincondeldchome.files.wordpress.com/2019/06/joe-west.jpg?w=500", newMensaje: 1),
];