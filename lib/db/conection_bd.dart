import 'package:mysql1/mysql1.dart';

class ConectionDb {
  static MySqlConnection? conn;

  static connection() async {
    try {
      var settings = ConnectionSettings(host: 'localhost', port: 3306, user: 'root', db: 'modtutorias');
      conn = await MySqlConnection.connect(settings);

      print('COnection DB : $conn');
    } catch (e) {
      print('ERRR: $e');
    }
  }
}
