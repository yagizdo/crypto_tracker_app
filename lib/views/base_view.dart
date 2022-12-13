import 'package:crypto_tracker/views/home_view.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_navbar.dart';
import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  const BaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      bottomNavigationBar: MainNavbar(
        tabs: [
          const HomeView(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
