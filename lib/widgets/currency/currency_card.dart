import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/currency.dart';
import '../../utils/app_colors.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({Key? key, required this.currency}) : super(key: key);
  final Currency currency;
  @override
  Widget build(BuildContext context) {
    // Deleted '%' from the start of the string
    String? inputWithoutPercentage = currency.change?.replaceFirst('%', '');

    // Deleted comma from the string
    String? inputWithoutComma = inputWithoutPercentage?.replaceFirst(',', '');

    // Converted string to double
    double? value = double.tryParse(inputWithoutComma ?? '0');

    // Now data like 4.0 , i wanna convert to like 0.04
    double? value2 = value! / 100;

    // Dot to comma and added '%' to the end of the string
    String updatedChange = value2.toString().replaceAll('.', ',').padLeft(value2.toString().length + 1, '%');

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 5.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white.withOpacity(0.9),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 3.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.star_border),
                  )),
              Expanded(flex: 3,child: Text(currency.name ?? 'No Data')),
              Expanded(flex : 3, child: Text(currency.buy.toString(), textAlign: TextAlign.start,)),
              // Currency change container
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: value2 > 0 ? Colors.green : Colors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.w,
                    ),
                    child: Text(
                      currency.change.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.blackBackground,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
