import 'package:annotated_shelf/annotated_shelf.dart';

class EstudianteModel extends Form {
  final int idEstudiante;
  final String nombre;

  EstudianteModel({required this.idEstudiante, required this.nombre});

  @override
  factory EstudianteModel.fromJson(Map<String, dynamic> map) {
    return EstudianteModel(idEstudiante: map['id_estudiante'], nombre: map['nombre']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id_estudiante": idEstudiante,
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

  String nameTable = 'estudiantes';
}
