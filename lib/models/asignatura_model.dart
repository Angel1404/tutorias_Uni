import 'package:annotated_shelf/annotated_shelf.dart';

class AsignaturaModel extends Form {
  final int idAsignatura;
  final String nombre;

  AsignaturaModel({required this.idAsignatura, required this.nombre});

  @override
  factory AsignaturaModel.fromJson(Map<String, dynamic> map) {
    return AsignaturaModel(
        idAsignatura: map['id_asignatura'], nombre: map['nombre']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id_asignatura": idAsignatura,
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

  String nameTable = 'asignaturas';
}
