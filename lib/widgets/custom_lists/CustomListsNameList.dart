import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/widgets/custom_lists/custom_lists_name_card.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../bloc/favorites_bloc/favorites_bloc.dart';

class CustomListsNamesList extends StatelessWidget {
  const CustomListsNamesList(
      {Key? key, required this.favoriteListNames, required this.onTap})
      : super(key: key);
  final List<dynamic> favoriteListNames;
  final ValueSetter<String> onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteListNames.length,
      itemBuilder: (context, index) {
        String listName = favoriteListNames[index];
        return TapWrapper(
            onTap: () {
              onTap(listName);
            },
            child: Slidable(
                key: UniqueKey(),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(
                    onDismissed: () {
                      BlocProvider.of<FavoritesBloc>(context).add(
                        DeleteCustomListEvent(
                          listName.toLowerCase(),
                        ),
                      );
                    },
                  ), children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        BlocProvider.of<FavoritesBloc>(context).add(
                          DeleteCustomListEvent(
                            listName.toLowerCase(),
                          ),
                        );
                      },
                      backgroundColor: Colors.redAccent,
                      label: LocaleKeys.custom_lists_slidable_remove_txt.tr(),
                    )
                  ],
                ),
                child: CustomListsNameCard(listName: listName)));
      },
    );
  }
}
