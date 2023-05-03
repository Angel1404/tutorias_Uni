import 'package:mysql1/mysql1.dart';

/* 
    Esta es una función genérica llamada getAllItems que toma dos argumentos: 
    la consulta SQL y la función fromJson 
    que se utilizará para convertir los resultados de la consulta en 
    objetos de modelo.
  */

Future<List<T>> getAllItems<T>(String sql, Function fromJson, {required MySqlConnection? db}) async {
  List<T> result = [];
  print(sql);
  final query = await db!.query(sql);
  print(query);
  for (var data in query) {
    print('Type: $data');
    result.add(fromJson(data.fields));
  }

  return result;
}
