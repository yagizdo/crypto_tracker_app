import 'package:flutter/material.dart';

import 'custom_fav_lists.dart';
import 'custom_list_detail.dart';

class CustomListContent extends StatefulWidget {
  const CustomListContent({Key? key}) : super(key: key);

  @override
  State<CustomListContent> createState() => _CustomListContentState();
}

class _CustomListContentState extends State<CustomListContent> {
  bool isDetail = false;
  String listName = '';
  @override
  Widget build(BuildContext context) {
    return isDetail ? CustomListDetail(listName: listName, onBack: (isBack) {
      setState((){
        isDetail = isBack;
      });
    },) : CustomFavLists(onTap: (listName){
      setState(() {
        isDetail = true;
        this.listName = listName;
      });
    },);
  }
}
