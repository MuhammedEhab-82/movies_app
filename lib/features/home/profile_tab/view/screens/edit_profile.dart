import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_responsive.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/utils/validators.dart';
import 'package:movies_app/core/utils/fire_base_utils.dart';
import '../../../../../core/cubit/user_cubit.dart';
import '../../../../auth/model/user_model.dart';
import '../../cubit/update_profile_view_model.dart';
import '../widgets/avatar_picker_sheet.dart';
import '../widgets/delete_account_dialog.dart';
import '../widgets/profile_action_buttons.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/profile_form_fields.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserModel currentUser;

  const UpdateProfileScreen({super.key, required this.currentUser});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}


class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final UpdateProfileViewModel viewModel = UpdateProfileViewModel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
  TextEditingController(text: '');

  final TextEditingController _phoneController =
  TextEditingController(text: '');

  final List<String> _avatars = [
      AppImages.profile01,
      AppImages.profile02,
      AppImages.profile03,
      AppImages.profile04,
      AppImages.profile05,
      AppImages.profile06,
      AppImages.profile07,
      AppImages.profile08,
      AppImages.profile09,
  ];

  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();

    viewModel.currentUser = widget.currentUser;

    _nameController.text = widget.currentUser.name;
    _phoneController.text = widget.currentUser.phone;
    _selectedAvatar = widget.currentUser.avatarUrl;

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await FireBaseUtils.getUserFromFirestore(
      widget.currentUser.id,
    );

    if (user != null && mounted) {
      _nameController.text = user.name;
      _phoneController.text = user.phone;
      _selectedAvatar = user.avatarUrl;

      viewModel.currentUser = user;

      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onSavePressed() async {
    if (_formKey.currentState!.validate()) {
      await viewModel.updateData(
        UserModel(
          id: widget.currentUser.id,
          name: _nameController.text,
          email: widget.currentUser.email,
          phone: _phoneController.text,
          avatarUrl: _selectedAvatar,
        ),
      );

      if (!mounted) return;

      final currentUser = context.read<UserCubit>().currentUser;

      if (currentUser != null) {
        final updatedUser = UserModel(
          id: currentUser.id,
          name: _nameController.text,
          email: currentUser.email,
          phone: _phoneController.text,
          avatarUrl: _selectedAvatar,
          watchlist: currentUser.watchlist,
          history: currentUser.history,
        );

        context.read<UserCubit>().updateUser(updatedUser);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.profileUpdated),
        ),
      );
    }
  }

  void _onDeleteAccountPressed() {
    showDeleteAccountDialog(
      context: context,
      onConfirm: () async {
        final userCubit = context.read<UserCubit>();

        await userCubit.deleteAccount(widget.currentUser);

        if (!mounted) return;

        Navigator.of(context).pop();
      },
    );
  }

  void _onAvatarTap() {
    showAvatarPicker(
      context: context,
      avatars: _avatars,
      selectedAvatar: _selectedAvatar,
      onSelected: (avatar) {
        setState(() => _selectedAvatar = avatar);
      },
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
                      const AssetImage(AppIcons.back),
            color: AppColors.primary,
            size: AppResponsive.w(context, 21),
          ),
        ),
        title: Text(
                  AppStrings.pickAvatar,
          style: AppStyles.reg16primary,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppResponsive.w(context, 16),
          ),
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
                          SizedBox(
                            height: AppResponsive.h(context, 12),
                          ),

                          ProfileAvatar(
                            avatarPath: _selectedAvatar,
                            onTap: _onAvatarTap,
                          ),

                          SizedBox(
                            height: AppResponsive.h(context, 24),
                          ),

                          ProfileFormFields(
                            nameController: _nameController,
                            phoneController: _phoneController,
                                                      nameValidator: Validators.name,
                                                      phoneValidator: Validators.phone,
                          ),

                          const Spacer(),

                          SizedBox(
                            height: AppResponsive.h(context, 24),
                          ),

                          ProfileActionButtons(
                            onDelete: _onDeleteAccountPressed,
                            onSave: _onSavePressed,
                          ),

                          SizedBox(
                            height: AppResponsive.h(context, 24),
                          ),
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