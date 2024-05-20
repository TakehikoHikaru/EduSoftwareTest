import 'package:edu/bloc/NameCensoListBloc.dart';
import 'package:edu/model/NameCenso.dart';
import 'package:edu/utils/LoaderUtil.dart';
import 'package:edu/utils/genderEnum.dart';
import 'package:edu/utils/statesEnum.dart';
import 'package:edu/view/CensoDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class NameCensoList extends StatefulWidget {
  const NameCensoList({super.key});

  @override
  State<NameCensoList> createState() => _NameCensoListState();
}

class _NameCensoListState extends State<NameCensoList> {
  NameCensoListBloc bloc = NameCensoListBloc();
  int? selectedState;
  String? selectedGender;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    // LoaderUtil.show(context);
    await bloc.getInitalNames();
    Loader.hide();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NameCenso>>(
      stream: bloc.blockStream,
      initialData: [],
      builder: (context, snapshot) => SingleChildScrollView(
        child: snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ExpansionTile(
                      title: Text("Filtros"),
                      children: [
                        Container(
                          width: double.maxFinite,
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Container(
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Estado"),
                                    DropdownButton<int?>(
                                      value: selectedState,
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(child: Text("Todos"), value: null),
                                        ...statesEnum.values.map((e) => DropdownMenuItem(child: Text(e.name), value: e.id)).toList(),
                                      ],
                                      onChanged: (v) {
                                        setState(() {
                                          selectedState = v;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Gênero"),
                                    DropdownButton<String?>(
                                      value: selectedGender,
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(child: Text("Todos"), value: null),
                                        ...genderEnum.values.map((e) => DropdownMenuItem(child: Text(e.showString), value: e.name)).toList(),
                                      ],
                                      onChanged: (v) {
                                        setState(() {
                                          selectedGender = v;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          width: double.maxFinite,
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () async {
                              LoaderUtil.show(context);
                              await bloc.getFilteredNames(selectedState, selectedGender);
                              Loader.hide();
                            },
                            child: Text("Filtrar"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...getCards(snapshot.data!),
                ],
              ),
      ),
    );
  }

  getCards(List<NameCenso> list) {
    List<Widget> result = [];
    for (var i = 0; i < list.length; i++) {
      NameCenso n = list[i];
      result.add(
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CensoDetails(censo: n),
            ),
          ),
          child: Container(
            color: i % 2 == 0 ? Colors.white : Colors.grey[200],
            child: Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.maxFinite,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.maxFinite,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          "#${n.rank} - ",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          n.name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return result;
  }
}
