// ignore_for_file: must_be_immutable

import 'package:edu/model/NameCenso.dart';
import 'package:edu/model/NameCensoDetails.dart';
import 'package:edu/service/NameCensoService.dart';
import 'package:edu/utils/LoaderUtil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class CensoDetails extends StatefulWidget {
  NameCenso censo;
  CensoDetails({required this.censo, super.key});

  @override
  State<CensoDetails> createState() => _CensoDetailsState();
}

class _CensoDetailsState extends State<CensoDetails> {
  List<NameCensoDetails>? censoDetails = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    isLoading = true;
    censoDetails = await NameCensoService().getCensoDetails(widget.censo.name);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Wrap(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Text(
                  "#${widget.censo.rank} - ${widget.censo.name}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black,
                Colors.black,
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
              ]),
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (censoDetails != null) ...[...censoDetails!.map((e) => DetailCard(e))]
                  ],
                )
        ],
      ),
    );
  }

  Widget DetailCard(NameCensoDetails details) {
    return Container(
      width: 300,
      height: 150,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(details.state, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          Text("População do estado: ${details.population}"),
          Text("Quantidade de pessoas: ${details.frequency}"),
          Text("Porcentagem de frequencia: ${(details.frequency / details.population * 100).toStringAsFixed(2)}%"),
        ],
      ),
    );
  }
}
