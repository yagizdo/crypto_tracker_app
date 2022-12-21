import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:crypto_tracker/widgets/settings/settings_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      appBar: _buildAppBar(),
      content: SettingsContent(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(LocaleKeys.settings_title.tr()),
    );
  }
}
