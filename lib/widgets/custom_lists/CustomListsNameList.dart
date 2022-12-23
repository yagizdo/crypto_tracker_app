import 'package:crypto_tracker/widgets/custom_lists/custom_lists_name_card.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:flutter/material.dart';

class CustomListsNamesList extends StatelessWidget {
  const CustomListsNamesList({Key? key, required this.favoriteListNames, required this.onTap})
      : super(key: key);
  final List<dynamic> favoriteListNames;
  final ValueSetter<String> onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteListNames.length,
      itemBuilder: (context, index) {
        var listName = favoriteListNames[index];
        return TapWrapper(
            onTap: () {
              onTap(listName);
            },
            child: CustomListsNameCard(listName: listName));
      },
    );
  }
}
