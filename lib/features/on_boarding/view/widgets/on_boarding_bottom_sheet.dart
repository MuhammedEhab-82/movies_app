import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/on_boarding/model/on_boarding_model.dart';
import '../../../../core/utils/app_strings.dart';

class OnBoardingBottomSheet extends StatefulWidget {
  final Function(int) onIndexChanged;

  const OnBoardingBottomSheet({super.key, required this.onIndexChanged});

  @override
  State<OnBoardingBottomSheet> createState() => _OnBoardingBottomSheetState();
}

class _OnBoardingBottomSheetState extends State<OnBoardingBottomSheet> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.w(context, 16),
        vertical: AppResponsive.h(context, 24),
      ),
      child: Column(
        spacing: AppResponsive.designHeight * 0.02,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            OnBoardingModel.titleList[selectedIndex],
            style: AppStyles.bold24white,
          ),
          Text(
            OnBoardingModel.descriptionList[selectedIndex],
            style: AppStyles.reg16white,
            textAlign: TextAlign.center,

          ),
          CustomButton(
            text: selectedIndex == 4 ? AppStrings.finish : AppStrings.next,
            onPressed: () {
              setState(() {
                if (selectedIndex < 4) {
                  selectedIndex++;
                  widget.onIndexChanged(selectedIndex);
                } else {
                  Navigator.of(context).pushNamed(AppRoutes.logIn);
                }
              });
            },
            width: double.infinity,
            textStyle: AppStyles.semi20darkGrey,
          ),

          if (selectedIndex != 0)
            CustomButton(
              text: AppStrings.back,
              onPressed: () {
                setState(() {
                  selectedIndex--;
                  widget.onIndexChanged(selectedIndex);
                });
              },
              width: double.infinity,
              isOutlined: true,
              textStyle: AppStyles.semi20primary,
            ),
        ],
      ),
    );
  }
}
