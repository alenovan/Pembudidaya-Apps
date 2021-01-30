import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart';
class LoadingDialog {
  final BuildContext context;
  LoadingDialog.show(this.context) {
    this._show();
  }

  void _show() {
    hideKeyboard(context);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              child: Wrap(
                children: [
                  Material(
                    elevation: 10,
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              backgroundColor: Colors.white),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Loading",
                            style: subtitle2Inv,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
