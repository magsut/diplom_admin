import 'package:http/http.dart' as http;

class ServerMetods{
  static Future<String> getAllCars()async{
    final uri = Uri.parse('http://192.168.0.121:3000/getCars');

    final http.Response response = await http.get(uri);

    return response.body;
  }

  static Future<String> getServicers(String mark,model,generation) async{
    final uri = Uri.parse('http://192.168.0.121:3000/getServices/${mark}/${model}/${generation}');

    final http.Response response = await http.get(uri);

    return response.body;
  }
}