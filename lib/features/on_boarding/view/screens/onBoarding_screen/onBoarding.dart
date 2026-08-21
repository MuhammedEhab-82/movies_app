import 'package:flutter/material.dart';
import 'package:movies_app/features/on_boarding/model/on_boarding_model.dart';
import 'package:movies_app/features/on_boarding/view/widgets/on_boarding_bottom_sheet.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (context) {
          return OnBoardingBottomSheet(
            onIndexChanged: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        OnBoardingModel.imgList[currentIndex],
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
