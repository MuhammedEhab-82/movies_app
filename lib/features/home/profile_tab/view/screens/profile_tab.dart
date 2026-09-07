import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/cubit/user_cubit.dart';
import 'package:movies_app/core/cubit/user_state.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/core/utils/app_colors.dart';
import 'package:movies_app/core/utils/app_strings.dart';
import 'package:movies_app/core/utils/app_styles.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/auth/model/user_model.dart';
import 'package:movies_app/features/home/profile_tab/view/widgets/tab_details.dart';
import 'package:movies_app/features/home/profile_tab/cubit/profile_view_model.dart';
import 'package:movies_app/features/home/profile_tab/cubit/profile_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/network/api_service.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/utils/app_responsive.dart';
import '../../../../../core/utils/app_routes.dart';
import '../../cubit/profile_tab_movies_cubit.dart';
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

  // cubits for each tab to keep separate loading states
  ProfileTabMoviesCubit? watchlistCubit;
  ProfileTabMoviesCubit? historyCubit;
  List<String> _lastWatchlist = [];
  List<String> _lastHistory = [];

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
  void dispose() {
    watchlistCubit?.close();
    historyCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final loggedInUser = state is UserAuthenticated ? state.user : null;

        final fallbackUser =
            loggedInUser ??
            UserModel(
              id: '',
              name: '',
              phone: '',
              avatarUrl: AppImages.avatarByIndex(1),
            );

        final uid = FirebaseAuth.instance.currentUser?.uid;

        return BlocProvider(
          create: (context) =>
              ProfileViewModel()..loadUser(uid ?? fallbackUser.id),
          child: BlocBuilder<ProfileViewModel, ProfileStates>(
            builder: (context, profileState) {
              final displayedUser = profileState is ProfileUserLoadedState
                  ? profileState.user
                  : fallbackUser;

              final watchlist = displayedUser.watchlist;
              final history = displayedUser.history;

              // ensure cubits exist
              watchlistCubit ??= ProfileTabMoviesCubit(
                MovieService(DioClient()),
              );
              historyCubit ??= ProfileTabMoviesCubit(MovieService(DioClient()));

              // load when lists change
              if (!_listEquals(_lastWatchlist, watchlist)) {
                watchlistCubit!.loadMovies(watchlist);
                _lastWatchlist = List.from(watchlist);
              }
              if (!_listEquals(_lastHistory, history)) {
                historyCubit!.loadMovies(history);
                _lastHistory = List.from(history);
              }

              final selectedCubit = currentIndex == 0
                  ? watchlistCubit!
                  : historyCubit!;

              final selectedMovies = currentIndex == 0 ? watchlist : history;

              return Scaffold(
                backgroundColor: AppColors.grayBg,
                body: SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ProfileSection(userModel: displayedUser),
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
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.updateProfile,
                                      arguments: displayedUser,
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: CustomButton(
                                  borderRadius: 15,
                                  text: AppStrings.exit,
                                  textStyle: AppStyles.reg20white,
                                  onPressed: () async {
                                    await context.read<UserCubit>().logout();

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
                      selectedMovies.isEmpty
                          ? SliverFillRemaining(
                              hasScrollBody: false,
                              child: Container(
                                color: AppColors.background,
                                child: Image.asset(AppImages.Empty),
                              ),
                            )
                          : SliverToBoxAdapter(
                              child: BlocProvider.value(
                                value: selectedCubit,
                                child: TabDetails(
                                  key: ValueKey(
                                    currentIndex == 0 ? 'watchlist' : 'history',
                                  ),
                                  movie: selectedMovies,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
