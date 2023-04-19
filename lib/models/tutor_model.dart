import 'package:annotated_shelf/annotated_shelf.dart';

class TutorModel extends Form {
  final int idTutor;
  final String nombre;

  TutorModel({required this.idTutor, required this.nombre});

  @override
  factory TutorModel.fromJson(Map<String, dynamic> map) {
    return TutorModel(idTutor: map['idTutor'], nombre: map['nombre']);
  }

  factory TutorModel.fromJsonBD(Map<String, dynamic> map) {
    return TutorModel(
      idTutor: map['id_tutor'] ?? '',
      nombre: map['nombre'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id_tutor": idTutor,
      "nombre": nombre,
    };
  }

  List<Object?> toListValuesInsert() {
    return [
      nombre,
    ];
  }

  String stringValues = '(?)';

  String stringValuesToInsert = '(nombre)';

  String nameTable = 'tutores';
}
