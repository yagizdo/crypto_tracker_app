import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../i18n/locale_keys.g.dart';
import '../../utils/app_colors.dart';
import 'settings_card.dart';

class DeleteAccountCard extends StatelessWidget {
  const DeleteAccountCard({Key? key, required this.onClick}) : super(key: key);
  final ValueSetter<bool> onClick;


  @override
  Widget build(BuildContext context) {
    return SettingsCard(
        title: LocaleKeys.settings_delete_account_btn_txt.tr(),
        backgroundColor: Colors.redAccent,
        isCenterText: true,
        titleColor: AppColors.white,
        onTap: (){
          onClick(true);
        });
  }
}
