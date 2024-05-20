class NameCenso {
  late String name;
  late int region;
  late int frequence;
  late int? rank = 0;
  late String gender;

  NameCenso(this.name, this.region, this.frequence, this.rank, this.gender);

  NameCenso.fromJson(Map<String, dynamic> json) {
    print(json);
    name = json['nome'];
    region = json['regiao'] ?? 0;
    frequence = json['freq'] ?? json['frequencia'];
    rank = json['rank'] ?? json['ranking'];
    gender = json['sexo'] ?? "";
  }

  Map<String, dynamic> toJson() => {
        'nome': name,
        'regiao': region,
        'freq': frequence,
        'rank': rank,
        'sexo': gender,
      };
}
