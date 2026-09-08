import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';

import '../../../../../core/utils/app_strings.dart';
import '../widgets/avatar_picker_sheet.dart';
import '../widgets/delete_account_dialog.dart';
import '../widgets/profile_action_buttons.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_form_fields.dart';
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
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppStrings.profileUpdated)),
      );
    }
  }

  void _onDeleteAccountPressed() {
    showDeleteAccountDialog(
      context: context,
      onConfirm: () {
        // TODO: hook up actual account-deletion logic here.
      },
    );
  }

  void _onAvatarTap() {
    showAvatarPicker(
      context: context,
      avatars: _avatars,
      selectedAvatar: _selectedAvatar,
      onSelected: (avatar) => setState(() => _selectedAvatar = avatar),
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
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          SizedBox(height: AppResponsive.h(context, 12)),

                          ProfileAvatar(
                            avatarPath: _selectedAvatar,
                            onTap: _onAvatarTap,
                          ),
                          SizedBox(height: AppResponsive.h(context, 24)),

                          ProfileFormFields(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            nameValidator: _validateName,
                            phoneValidator: _validatePhone,
                          ),

                          const Spacer(),
                          SizedBox(height: AppResponsive.h(context, 24)),

                          ProfileActionButtons(
                            onDelete: _onDeleteAccountPressed,
                            onSave: _onSavePressed,
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