import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/services/navigation_service.dart';
import 'package:crypto_tracker/utils/extensions/context_extension.dart';
import 'package:crypto_tracker/widgets/custom_lists/custom_lists_name_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/favorites_bloc/favorites_bloc.dart';
import '../utils/app_colors.dart';
import '../utils/app_textstyles.dart';
import '../widgets/main_widgets/tapWrapper.dart';

class AlertHelper {
  AlertHelper._();

  static final shared = AlertHelper._();

  final TextEditingController _listNameController = TextEditingController();
  final NavigationService _navigationService = getIt<NavigationService>();

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

  // Future<void> parameter
  Future<void> addCustomListDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.blueBackground,
            title: const Text('Add a new list'),
            titleTextStyle: AppTextStyle.customListNameTitle(),
            content: TextField(
              controller: _listNameController,
              decoration: const InputDecoration(
                  hintText: "Enter a name for the list",
                  labelStyle: TextStyle(color: AppColors.white),
                  hintStyle: TextStyle(color: AppColors.white)),
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    AppTextStyle.addCustomListDialogBtnTxt(),
                  ),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('CANCEL'),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                ),
                onPressed: () async {
                  if (_listNameController.text.isNotEmpty) {
                    BlocProvider.of<FavoritesBloc>(context)
                        .add(AddCustomListEvent(_listNameController.text));
                    _listNameController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add List'),
              ),
            ],
          );
        });
  }

  Future<void> addItemToCustomListDialog(
      {required BuildContext context, required String itemName}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.blueBackground,
            title: const Text('Add to a list'),
            titleTextStyle: AppTextStyle.customListNameTitle(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is CustomListNamesLoadedState) {
                  return SizedBox(
                    height: 400.w,
                    width: 500.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.customListNames.length,
                      itemBuilder: (context, index) {
                        return TapWrapper(
                            onTap: () {
                              BlocProvider.of<FavoritesBloc>(context).add(
                                  AddItemToCustomListEvent(
                                      listName: state.customListNames[index],
                                      itemName: itemName));
                              _navigationService.showSuccessSnackbar(errorMessage: "Added to ${state.customListNames[index]} list");
                              Navigator.pop(context);
                            },
                            child: CustomListsNameCard(
                              listName: state.customListNames[index],
                            ));
                      },
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 400.w,
                    width: 500.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            actions: [
              TextButton(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    AppTextStyle.addCustomListDialogBtnTxt(),
                  ),
                  foregroundColor: MaterialStateProperty.all(AppColors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('CANCEL',style: AppTextStyle.addCustomListDialogCancelBtnTxt(),),
              ),
            ],
          );
        });
  }
}
