import 'dart:convert';

import 'package:edu/model/NameCenso.dart';
import 'package:edu/model/NameCensoDetails.dart';
import 'package:http/http.dart' as http;

class NameCensoService {
  NameCensoService._privateConstructor();
  static final NameCensoService _instance = NameCensoService._privateConstructor();
  factory NameCensoService() => _instance;

  Future<List<NameCenso>?> getNames({int? state, String? gender}) async {
    try {
      String url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/";
      if (state != null || gender != null) {
        url = url + "ranking?";
        if (state != null) {
          url = url + "localidade=" + state.toString();
        }
        if (gender != null) {
          url = url + (state != null ? "&" : "") + "sexo=" + gender;
        }
      }
      print(url);
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        return null;
      }
      List json = jsonDecode(response.body);
      if (state != null || gender != null) {
        json = json[0]["res"];
      }
      return json.map((n) => NameCenso.fromJson(n)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<NameCensoDetails>?> getCensoDetails(String name) async {
    try {
      String url = "https://servicodados.ibge.gov.br/api/v2/censos/nomes/$name?groupBy=UF";
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        return null;
      }
      List json = jsonDecode(response.body);

      return json.map((n) => NameCensoDetails.fromJson(n)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
