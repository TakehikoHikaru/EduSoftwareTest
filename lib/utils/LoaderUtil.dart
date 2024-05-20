import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoaderUtil {
  static void show(BuildContext context) {
    return Loader.show(
      context,
      isAppbarOverlay: true,
      isBottomBarOverlay: false,
      overlayFromBottom: 0,
      // ignore: deprecated_member_use
      themeData: Theme.of(context).copyWith(primaryColor: Colors.black38),
      overlayColor: Colors.black38,
      progressIndicator: Center(
        child: Container(
          width: 350,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  "Aguarde...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
