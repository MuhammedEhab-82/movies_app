import 'package:flutter/material.dart';
import 'package:smart_empty_state/smart_empty_state.dart';

import '../errors/api_error.dart';
import 'app_colors.dart';
import 'app_strings.dart';
import 'app_styles.dart';

class EmptyStateUtils {
  EmptyStateUtils._();
  static EmptyStateType getEmptyStateType(String message) {
    final errorMessage = message.toLowerCase();

    if (errorMessage.contains('internet') ||
        errorMessage.contains('network') ||
        errorMessage.contains('connection')) {
      return EmptyStateType.noInternet;
    }
    if (errorMessage.contains('unauthorized')) {
      return EmptyStateType.permissionDenied;
    }

    return EmptyStateType.error;
  }

  static final SmartEmptyStateTheme emptyStateTheme = SmartEmptyStateTheme(
    iconColor: AppColors.primary,
    titleStyle: AppStyles.transparent,
    messageStyle: AppStyles.semi20primary,
  );
  static Widget buildNoDataState({required VoidCallback onRetry}) {
    return SmartEmptyState(
      type: EmptyStateType.noData,
      theme: EmptyStateUtils.emptyStateTheme,
      options: const EmptyStateOptions(
        title: 'No Movies',
        message: 'No movie data found.',
        actionText: 'Try Again',
      ),
      onAction: onRetry,
    );
  }
  static Widget buildErrorState({
    required ApiError error,
    required VoidCallback onRetry,
  }) {
    return SmartEmptyState(
      type: EmptyStateUtils.getEmptyStateType(error.message),
      theme: EmptyStateUtils.emptyStateTheme,
      options: EmptyStateOptions(
        message: error.message,
        actionText: AppStrings.tryAgain,
      ),
      onAction: onRetry,
    );
  }
  static Widget buildEmptyState(int currentIndex) {
    return SmartEmptyState(
      type: EmptyStateType.noData,
      theme: EmptyStateUtils.emptyStateTheme,
      options: EmptyStateOptions(
        title: AppStrings.noMoviesFound,
        message: currentIndex == 0
            ? AppStrings.noMoviesFoundMessage
            : AppStrings.noMoviesFoundMessage,
      ),
    );
  }
}
