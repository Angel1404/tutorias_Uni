import 'package:annotated_shelf/annotated_shelf.dart';

class TutorModel extends Form {
  final int idTutor;
  final String nombre;

  TutorModel({required this.idTutor, required this.nombre});

  //MEtodo a usar para los metodos Post o Put
  //TODO: Poner las Keys como estan los nombres de las variables de esta clase (map['Key'])
  @override
  factory TutorModel.fromJson(Map<String, dynamic> map) {
    //MEtodo que convierte el mapa recibido desde cualquier lado (Exam. Postmant)
    return TutorModel(idTutor: map['idTutor'], nombre: map['nombre']);
  }

  //MEtodo para usar en los get. que traen los valores de la Bd
  //TODO: Poner las Keys como estan las propiedades en la Bd (map['Key'])
  factory TutorModel.fromJsonToLocal(Map<String, dynamic> map) {
    return TutorModel(idTutor: map['id_tutor'], nombre: map['nombre']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id_tutor": idTutor,
      "nombre": nombre,
    };
  }

  String nameTable = 'tutor';
}
