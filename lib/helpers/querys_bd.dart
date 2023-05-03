import 'package:tutotias_uni/helpers/names_tables.dart';

/// Querys de las consultas para la base de datos.
class QuerysBd {
  static String selectAllDataQuery({String? table}) {
    table ??= tableTutoresName;
    return "SELECT * FROM $table WHERE estado = '1' ";
  }

  static String selectOnlyData({String? table, required int id}) {
    table ??= tableTutoriasName;
    return "SELECT * FROM $table WHERE estado = '1' AND id_tutoria = $id";
  }

  static String insertQuery({String? table, required String values, required String valuesToInsert}) {
    table ??= tableTutoriasName;
    return 'INSERT INTO $table $valuesToInsert VALUES $values';
  }

  static String updateQyery({String? table, required int id, required String idText, required String valuesToUpdate}) {
    table ??= tableTutoriasName;
    return 'UPDATE $table SET $valuesToUpdate WHERE $idText = $id';
  }

  static String deletequery({String? table, required int id, required String idText}) {
    table ??= tableTutoriasName;
    return 'DELETE FROM $table WHERE $idText = $id';
  }
}
