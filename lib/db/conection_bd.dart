import 'package:mysql1/mysql1.dart';

class ConectionDb {
  static MySqlConnection? conn;

  static connection() async {
    try {
      var settings = ConnectionSettings(host: 'localhost', port: 3306, user: 'root', db: 'modtutorias'); //Setting para la conexion
      conn = await MySqlConnection.connect(settings); //Conexion

      print('COnection DB : $conn');
    } catch (e) {
      print('ERRR: $e');
    }
  }
}
