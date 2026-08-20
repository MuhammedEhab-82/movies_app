// import 'package:flutter/material.dart';
// import 'package:movies_app/core/utils/app_responsive.dart';
// import 'package:movies_app/core/utils/app_routes.dart';
// import 'package:movies_app/core/utils/app_styles.dart';
// import 'package:movies_app/core/widgets/custom_button.dart';
// import 'package:movies_app/features/on_boarding/model/on_boarding_model.dart';
// import '../../../../core/utils/app_strings.dart';
//
// class OnBoardingBottomSheet extends StatefulWidget {
// final Function(int) onIndexChanged;
//   const OnBoardingBottomSheet({super.key,required this.onIndexChanged});
//
//   @override
//
//   State<OnBoardingBottomSheet> createState() => _OnBoardingBottomSheetState();
// }
//
// class _OnBoardingBottomSheetState extends State<OnBoardingBottomSheet> {
// int selectedIndex =0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: AppResponsive.designWidth*0.1),
//           child: Column(
//             spacing:AppResponsive.designHeight*0.02,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               OnBoardingModel.titleList[selectedIndex],
//               OnBoardingModel.descriptionList[selectedIndex],
//
//               CustomButton(text:selectedIndex ==4 ? AppStrings.finish : AppStrings.next, onPressed: (){
//                 //todo :
//                 if (selectedIndex==4){
//                   Navigator.of(context).pushNamed(AppRoutes.introduction);
//                 }else{
//                   setState(() {
//                     widget.onIndexChanged(selectedIndex);
//                   });
//                 }
//               }
//               ,width: double.infinity,
//                 textStyle: AppStyles.semi20darkGrey,
//               ),
//              if (selectedIndex!=0)
//           CustomButton(text:AppStrings.back, onPressed: (){
//           //todo : back
//             setState(() {
//               widget.onIndexChanged(selectedIndex - 1);
//               });
//                 }
//           ,width: double.infinity,
//           isOutlined: true,
//           textStyle: AppStyles.semi20primary,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_routes.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/on_boarding/model/on_boarding_model.dart';
import '../../../../core/utils/app_strings.dart';

class OnBoardingBottomSheet extends StatefulWidget {
  final Function(int) onIndexChanged; // بنبعت الindx للشاشة الرئيسية عشان الصورة تغير

  const OnBoardingBottomSheet({super.key, required this.onIndexChanged});

  @override
  State<OnBoardingBottomSheet> createState() => _OnBoardingBottomSheetState();
}

class _OnBoardingBottomSheetState extends State<OnBoardingBottomSheet> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppResponsive.designWidth * 0.1,vertical: AppResponsive.designHeight*0.02),
      child: Column(
        spacing: AppResponsive.designHeight * 0.02,
        mainAxisSize: MainAxisSize.min,
        children: [
          OnBoardingModel.titleList[selectedIndex],
          OnBoardingModel.descriptionList[selectedIndex],

          // زرار الـ Next / Finish
          CustomButton(
            text: selectedIndex == 4 ? AppStrings.finish : AppStrings.next,
            onPressed: () {
              setState(() {
                if (selectedIndex < 4) {
                  selectedIndex++;
                  widget.onIndexChanged(selectedIndex); // بنعرف الصورة تتغير برة
                } else {
                  // TODO: لو وصلنا لـ Finish ننتقل للهوم
                  Navigator.of(context).pushNamed(AppRoutes.home);
                }
              });
            },
            width: double.infinity,
            textStyle: AppStyles.semi20darkGrey,
          ),

          // زرار الـ Back يظهر لو الـ selectedIndex != 0
          if (selectedIndex != 0)
            CustomButton(
              text: AppStrings.back,
              onPressed: () {
                setState(() {
                  selectedIndex--;
                  widget.onIndexChanged(selectedIndex); // بنعرف الصورة ترجع ورا برة
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