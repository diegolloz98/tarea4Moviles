import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:money_track/user_page/cuenta.dart';
class DataService{
  final _baseUrl = 'api.sheety.co/12948897d56ef720d45bb409c83b07ad/dummyApi';
  Future <List<Cuenta>> getCuentas() async {
    try{
      final url = Uri.https(_baseUrl, '/cuentas');
      final response = await http.get(url);
      if(response.statusCode == 200){
        final json = jsonDecode(response.body) as List;
        final cuentas = json.map((e) => Cuenta.fromJson(e)).toList();
        return cuentas;
      }else{
        throw Exception('Faild to load cuentas');
      }
    }catch(e){
      rethrow;
    }
    
  }
}