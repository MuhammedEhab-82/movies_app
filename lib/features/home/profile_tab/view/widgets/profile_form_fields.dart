import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';

import '../../../../../core/utils/app_strings.dart';


class ProfileFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String? Function(String?) nameValidator;
  final String? Function(String?) phoneValidator;

  const ProfileFormFields({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.nameValidator,
    required this.phoneValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          hintText: AppStrings.name,
          prefixIcon: AppIcons.profile,
          textInputAction: TextInputAction.next,
          validator: nameValidator,
        ),
        SizedBox(height: AppResponsive.h(context, 16)),

        CustomTextField(
          controller: phoneController,
          hintText: AppStrings.phoneNumber,
          prefixIcon: AppIcons.phone,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          validator: phoneValidator,
        ),
        SizedBox(height: AppResponsive.h(context, 16)),

      ],
    );
  }
}