import 'package:edu/utils/statesEnum.dart';

class NameCensoDetails {
  late String state;
  late int frequency;
  late int population;

  NameCensoDetails(this.state, this.frequency, this.population);

  NameCensoDetails.fromJson(Map<String, dynamic> json) {
    state = statesEnum.values.firstWhere((element) => element.id == int.parse(json["localidade"])).name;

    var res = json["res"][0];
    frequency = res["frequencia"];
    population = res["populacao"];
  }
}
