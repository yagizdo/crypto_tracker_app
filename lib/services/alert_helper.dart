import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/utils/extensions/context_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_constants.dart';
import '../widgets/main_widgets/tapWrapper.dart';

class AlertHelper {
  AlertHelper._();

  static final shared = AlertHelper._();

  void showCupertinoChooseDialog(
      {required BuildContext context,
      required String title,
      required List<CupertinoActionSheetAction> actions}) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            title: Text(title),
            cancelButton: CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.settings_delete_account_alert_cancel.tr()),
            ),
            actions: actions,
          );
        });
  }

  Future<void> showCupertinoAlertDialog(
      {required BuildContext context,
      required String title,
      String? message}) async {
    await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: message != null ? Text(message) : null,
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void showCupertinoConfirmDialog(
      {required BuildContext context,
      required String title,
      required VoidCallback onConfirm,
      String? message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: message != null ? Text(message) : null,
            actions: [
              CupertinoDialogAction(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  onConfirm();
                },
                child: const Text("OK"),
              ),
            ],
          );
        });
  }

  void showCustomizableCupertinoAlertDialog(
      {required BuildContext context,
      required String title,
      String? message,
      required List<Widget> actions}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: message != null ? Text(message) : null,
            actions: actions,
          );
        });
  }

  void showSnackBar(String message, BuildContext context,
      [bool isPositive = true]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isPositive
                ? Icons.check_circle_outline_outlined
                : Icons.highlight_off,
            color: Colors.white,
            size: context.getHeight(0.02),
          ),
          SizedBox(
            width: context.getWidth(0.01),
          ),
          /* AutoSizeText(
            message,
            style: TextStyle(
                fontSize: context.getWidth(0.035), color: Colors.white),
            maxLines: 1,
          ),*/
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: context.getHeight(0.065)),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 1),
      elevation: 4,
    ));
  }

  showRatingDialog(BuildContext context) {
    // set up the buttons
    Widget noButton = TextButton(
      child: const Text(
        "NO",
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget sureButton = TapWrapper(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: context.screenWidth * 0.3,
          height: context.screenWidth * 0.08,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(30.5),
          ),
          child: const Text(
            'SURE',
          ),
        ));

    // set up the AlertDialog
    Widget alert = AlertDialog(
      title: const Text(
        "We hope you’re enjoying!",
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side:
            BorderSide(color: Colors.white, width: context.screenWidth * 0.005),
      ),
      content: Container(
        alignment: Alignment.center,
        height: context.screenWidth * 0.45,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "We are a small team and we make apps for people to enjoy.",
                textAlign: TextAlign.center,
              ),
              height15Per(context: context),
              const Text(
                "Can you give us a good review?",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            noButton,
            sureButton,
          ],
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
