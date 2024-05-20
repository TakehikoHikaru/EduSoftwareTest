import 'dart:async';

import 'package:edu/model/NameCenso.dart';
import 'package:edu/service/NameCensoService.dart';

class NameCensoListBloc {
  List<NameCenso> _nameCensoList = [];

  get nameCensoList => _nameCensoList;

  final _blocController = StreamController<List<NameCenso>>();

  Stream<List<NameCenso>> get blockStream => _blocController.stream;

  getInitalNames() async {
    List<NameCenso>? newData = await NameCensoService().getNames();
    _blocController.sink.add(newData ?? []);
  }

  getFilteredNames(int? state, String? gender) async {
    List<NameCenso>? newData = await NameCensoService().getNames(state: state, gender: gender);

    _blocController.sink.add(newData ?? []);
  }

  closeStream() {
    _blocController.close();
  }
}
