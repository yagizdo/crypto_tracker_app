import 'package:crypto_tracker/widgets/custom_lists/custom_lists_name_card.dart';
import 'package:flutter/material.dart';

class CustomListsNamesList extends StatelessWidget {
  const CustomListsNamesList({Key? key, required this.favoriteListNames})
      : super(key: key);
  final List<dynamic> favoriteListNames;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteListNames.length,
      itemBuilder: (context, index) {
        var listName = favoriteListNames[index];
        return CustomListsNameCard(listName: listName);
      },
    );
  }
}
