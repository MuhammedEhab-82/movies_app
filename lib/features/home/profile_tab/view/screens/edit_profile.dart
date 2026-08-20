import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_field.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(
    text: 'John Safwat',
  );

  final TextEditingController _phoneController = TextEditingController(
    text: '01200000000',
  );

  final List<String> _avatars = [
    AppImages.Profile01,
    AppImages.Profile02,
    AppImages.Profile03,
    AppImages.Profile04,
    AppImages.Profile05,
    AppImages.Profile06,
    AppImages.Profile07,
    AppImages.Profile08,
    AppImages.Profile09,
  ];

  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _avatars.first;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    final RegExp phoneRegex = RegExp(r'^01[0-2,5][0-9]{8}$');

    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
    }
  }

  void _onDeleteAccountPressed() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.gray,
          title: Text('Delete Account', style: AppStyles.bold20primary),
          content: Text(
            'Are you sure you want to delete your account? '
                'This action cannot be undone.',
            style: AppStyles.reg16white,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('Cancel', style: AppStyles.reg16white),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Delete',
                style: AppStyles.reg16primary.copyWith(color: AppColors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              left: AppResponsive.w(context, 10),
              right: AppResponsive.w(context, 10),
              bottom: AppResponsive.h(context, 10),
            ),
            padding: EdgeInsets.all(AppResponsive.w(context, 12)),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(18),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _avatars.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext gridContext, int index) {
                final String avatar = _avatars[index];
                final bool isSelected = avatar == _selectedAvatar;

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    setState(() => _selectedAvatar = avatar);
                    Navigator.pop(bottomSheetContext);
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.background,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(avatar, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return GestureDetector(
      onTap: _showAvatarPicker,
      child: SizedBox(
        width: AppResponsive.w(context, 150),
        height: AppResponsive.w(context, 150),
        child: ClipOval(
          child: Image.asset(_selectedAvatar, fit: BoxFit.cover),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: ImageIcon(
            const AssetImage(AppIcons.Back),
            color: AppColors.primary,
            size: AppResponsive.w(context, 21),
          ),
        ),
        title: Text('Pick Avatar', style: AppStyles.reg16primary),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppResponsive.w(context, 16)),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,

            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: AppResponsive.h(context, 12)),

                          _buildProfileAvatar(context),
                          SizedBox(height: AppResponsive.h(context, 24)),

                          CustomTextField(
                            controller: _nameController,
                            hintText: 'Name',
                            prefixIcon: const ImageIcon(
                              AssetImage(AppIcons.Profile),
                            ),
                            textInputAction: TextInputAction.next,
                            validator: _validateName,
                          ),
                          SizedBox(height: AppResponsive.h(context, 16)),

                          CustomTextField(
                            controller: _phoneController,
                            hintText: 'Phone Number',
                            prefixIcon: const ImageIcon(
                              AssetImage(AppIcons.Phone),
                            ),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            validator: _validatePhone,
                          ),
                          SizedBox(height: AppResponsive.h(context, 16)),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Reset Password',
                              style: AppStyles.reg14white,
                            ),
                          ),

                          const Spacer(),
                          SizedBox(height: AppResponsive.h(context, 24)),

                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Delete Account',
                              borderRadius: 15,
                              textStyle: AppStyles.reg14white,
                              onPressed: _onDeleteAccountPressed,
                              color: AppColors.red,
                              textColor: AppColors.white,
                            ),
                          ),
                          SizedBox(height: AppResponsive.h(context, 12)),

                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'Update Data',
                              borderRadius: 15,
                              textStyle: AppStyles.reg14white,
                              onPressed: _onSavePressed,
                              color: AppColors.primary,
                              textColor: Colors.black,
                            ),
                          ),
                          SizedBox(height: AppResponsive.h(context, 24)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}