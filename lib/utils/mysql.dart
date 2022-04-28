import 'package:mysql1/mysql1.dart';

class MySql{
  static String host = 'sql11.freesqldatabase.com',
                user = 'sql11488530',
                password = 'z1RezDJvJF',
                db = 'sql11488530';
  static int port = 3306;

  MySql();

  Future<MySqlConnection> getConnection() async{
    var settings = ConnectionSettings(
      host: host,
      db: db,
      password: password,
      port: port,
      user: user,
      characterSet: CharacterSet.UTF8
    );

    return await MySqlConnection.connect(settings);
  }
}