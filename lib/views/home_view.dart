import 'package:crypto_tracker/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:crypto_tracker/widgets/favorites/favorite_lists_content.dart';
import 'package:crypto_tracker/widgets/main_widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoritesBloc>(context,listen: false).add(GetCustomListNamesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return const MainLayout(
      content: Center(
        child: FavoritesContent(),
      ),
    );
  }
}
