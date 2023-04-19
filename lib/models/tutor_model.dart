import 'package:annotated_shelf/annotated_shelf.dart';

class TutorModel extends Payload {
  final int idTutor;
  final String nombre;

  TutorModel({required this.idTutor, required this.nombre});

  factory TutorModel.fromJson(Map<String, dynamic> map) {
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
