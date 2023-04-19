import 'package:tutotias_uni/helpers/names_tables.dart';

/// Querys de las consultas para la base de datos.
class QuerysBd {
  static String selectAllDataQuery({String? table}) {
    table ??= tableTutoresName;
    return 'SELECT * FROM $table';
  }

  static String insertQuery({String? table, required String values, required String valuesToInsert}) {
    table ??= tableTutoriasName;
    return 'INSERT INTO $table $valuesToInsert  VALUES $values';
  }
}
