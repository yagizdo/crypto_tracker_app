import 'package:crypto_tracker/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/widgets/crypto/crypto_card.dart';
import 'package:crypto_tracker/widgets/currency/currency_card.dart';
import 'package:crypto_tracker/widgets/main_widgets/tapWrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../i18n/locale_keys.g.dart';
import '../../models/crypto.dart';
import '../../models/currency.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_textstyles.dart';

class CustomListDetail extends StatefulWidget {
  const CustomListDetail({Key? key, required this.listName, required this.onBack}) : super(key: key);
  final String listName;
  final ValueSetter<bool> onBack;

  @override
  State<CustomListDetail> createState() => _CustomListDetailState();
}

class _CustomListDetailState extends State<CustomListDetail> {
  Future<void> _getCustomListInDatabase() async {
    BlocProvider.of<FavoritesBloc>(context).add(GetCustomListEvent(
      widget.listName,
    ));
  }

  @override
  void initState() {
    super.initState();
    _getCustomListInDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height1Per(context: context),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 25.w, right: 25.w),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.blueBackground,
              ),
              child: Row(
                children: [
                  IconButton(onPressed: () async {
                    BlocProvider.of<FavoritesBloc>(context).add(GetCustomListNamesEvent());
                    widget.onBack(false);
                  }, icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    widget.listName,
                    style: AppTextStyle.customListNameTitle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 20,
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is CustomListLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CustomListLoadedState) {
                  return ListView.builder(
                    itemCount: state.customListItems.length,
                    itemBuilder: (context, index) {
                      var item = state.customListItems[index];
                      if (item is Currency) {
                        return TapWrapper(
                            onTap: (){
                              BlocProvider.of<FavoritesBloc>(context,listen: false).add(DeleteItemFromCustomListEvent(item.name!, widget.listName.toLowerCase()));
                            },
                            child: CurrencyCard(currency: item, isFavorite: true));
                      }

                      if (item is Crypto) {
                        return CryptoCard(crypto: item, isFavorite: true);
                      }

                      return const SizedBox();
                    },
                  );
                } else if (state is CustomListErrorState) {
                  return Center(
                    child: Text(
                      LocaleKeys.errors_custom_error.tr(),
                      style: AppTextStyle.homeText(),
                    ),
                  );
                } if (state is CustomListEmptyState) {
                  return Center(
                    child: Text(
                      LocaleKeys.currency_no_item.tr(),
                      style: AppTextStyle.homeText(),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
      ],
    );
  }
}
