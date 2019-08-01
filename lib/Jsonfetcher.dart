import 'dart:convert';
import 'package:http/http.dart' as http;
import 'IssData.dart';

Future<IssData> obtenerDesdeApi() async {
  final response =
      await http.get('https://api.wheretheiss.at/v1/satellites/25544');
  if (response.statusCode == 200) {
    return IssData.fromApi(json.decode(response.body));
  } else {
    throw Exception('Sin Ineternet');
  }
}
