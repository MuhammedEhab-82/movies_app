import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/cubit/user_state.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/home/profile_tab/model/user_profile.dart';
import 'package:movies_app/features/home/profile_tab/view/widgets/tab_details.dart';

import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_routes.dart';
import '../widgets/profile_section.dart';
import '../widgets/tab_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      if (tabController.index != currentIndex) {
        setState(() => currentIndex = tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        // The logged-in user, linked here straight from UserCubit
        // (populated by LoginCubit/RegisterCubit on success).
        final loggedInUser = state is UserAuthenticated ? state.user : null;

        final userProfile = UserProfile(
          name: loggedInUser?.name ?? '',
          avatarUrl: AppImages.avatarByIndex(loggedInUser?.avatar ?? 1),
          // TODO: wire these up to Firestore (favorites/history feature).
          watchlist: const [],
          history: const [],
        );

        final selectedMovies = currentIndex == 0
            ? userProfile.watchlist
            : userProfile.history;

        return Scaffold(
          backgroundColor: AppColors.grayBg,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: ProfileSection(userProfile: userProfile),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppResponsive.h(context, 24)),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.w(context, 16),
                    ),
                    child: Row(
                      spacing: AppResponsive.w(context, 10),
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            borderRadius: 15,
                            text: AppStrings.editProfile,
                            textStyle: AppStyles.reg20white,
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(AppRoutes.updateProfile);
                            },
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            borderRadius: 15,
                            text: AppStrings.exit,
                            textStyle: AppStyles.reg20white,
                            onPressed: () async {
                              await context.read<UserCubit>().signOut();
                              if (context.mounted) {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed(AppRoutes.logIn);
                              }
                            },
                            color: AppColors.red,
                            textColor: AppColors.white,
                            icon: AppIcons.Exit,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppResponsive.h(context, 24)),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    controller: tabController,
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      TabWidget(
                        icon: AppIcons.WatchList,
                        name: AppStrings.watchlist,
                      ),
                      TabWidget(
                        icon: AppIcons.History,
                        name: AppStrings.history,
                      ),
                    ],
                  ),
                ),
                selectedMovies!.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          color: AppColors.background,
                          child: Image.asset(AppImages.Empty),
                        ),
                      )
                    : SliverToBoxAdapter(
                        child: TabDetails(movie: selectedMovies),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
