import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_responsive.dart';


Future<void> showAvatarPicker({
  required BuildContext context,
  required List<String> avatars,
  required String selectedAvatar,
  required ValueChanged<String> onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext sheetContext) {
      return _AvatarPickerSheet(
        avatars: avatars,
        selectedAvatar: selectedAvatar,
        onSelected: (avatar) {
          onSelected(avatar);
          Navigator.pop(sheetContext);
        },
      );
    },
  );
}

class _AvatarPickerSheet extends StatelessWidget {
  final List<String> avatars;
  final String selectedAvatar;
  final ValueChanged<String> onSelected;

  const _AvatarPickerSheet({
    required this.avatars,
    required this.selectedAvatar,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
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
          itemCount: avatars.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            final String avatar = avatars[index];
            return _AvatarTile(
              avatar: avatar,
              isSelected: avatar == selectedAvatar,
              onTap: () => onSelected(avatar),
            );
          },
        ),
      ),
    );
  }
}

class _AvatarTile extends StatelessWidget {
  final String avatar;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvatarTile({
    required this.avatar,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: ClipOval(
            child: Image.asset(avatar, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}