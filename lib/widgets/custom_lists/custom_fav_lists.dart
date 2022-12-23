import 'package:crypto_tracker/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';
import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_textstyles.dart';
import 'CustomListsNameList.dart';

class CustomFavLists extends StatefulWidget {
  const CustomFavLists({Key? key, required this.onTap}) : super(key: key);
  final ValueSetter<String> onTap;
  @override
  State<CustomFavLists> createState() => _CustomFavListsState();
}

class _CustomFavListsState extends State<CustomFavLists> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _listNameController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _listNameController = TextEditingController();
  }

  @override
  void dispose() {
    _listNameController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is CustomListNamesLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3.w,
            ),
          );
        }

        if (state is CustomListNamesErrorState) {
          return Center(
            child: Text(
              LocaleKeys.errors_custom_error.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }

        if (state is CustomListEmptyState) {
          return Center(
            child: Text(
              LocaleKeys.currency_no_item.tr(),
              style: AppTextStyle.homeText(),
            ),
          );
        }
        if (state is CustomListNamesLoadedState) {
          return Stack(
            children: [
              Column(
                children: [
                  height1Per(context: context),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.blueBackground,
                        ),
                        child: Text(
                          LocaleKeys.custom_lists_title.tr(),
                          style: AppTextStyle.customListNameTitle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 20,
                      child: CustomListsNamesList(
                        favoriteListNames: state.customListNames,
                        onTap: (listName) {
                          widget.onTap(listName);
                        },
                      )),
                ],
              ),
              Positioned(
                  bottom: 120.w,
                  right: 10.w,
                  child: FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () {
                      _displayTextInputDialog(context);
                    },
                  )),
            ],
          );
        }
        return Center(
          child: Text(LocaleKeys.currency_no_item.tr()),
        );
      },
    );
  }

  Future<void> addCustomListName() async {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<FavoritesBloc>(context)
          .add(AddCustomListEvent(_listNameController.text));
      _listNameController.clear();
      Navigator.pop(context);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: AppColors.blueBackground,
            title: const Text('Add a new list'),
            titleTextStyle: AppTextStyle.customListNameTitle(),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _listNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.errors_auth_validation_empty_error.tr();
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "Enter a name for the list",
                    labelStyle: TextStyle(color: AppColors.white),
                    hintStyle: TextStyle(color: AppColors.white)),
              ),
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
                  await addCustomListName();
                },
                child: const Text('Add List'),
              ),
            ],
          );
        });
  }
}
