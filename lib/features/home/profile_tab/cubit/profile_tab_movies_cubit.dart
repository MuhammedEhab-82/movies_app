import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/api_service.dart';
import 'package:movies_app/core/services/offline_movie_cache.dart';
import 'package:movies_app/core/utils/app_assets.dart';
import 'package:movies_app/features/home/browse_tab/model/movie_model.dart';

import 'profile_tab_movies_state.dart';

class ProfileTabMoviesCubit extends Cubit<ProfileTabMoviesState> {
  final MovieService _movieService;

  ProfileTabMoviesCubit(this._movieService) : super(ProfileTabMoviesInitial());

  Future<void> loadMovies(List<String> ids) async {
    if (ids.isEmpty) {
      emit(ProfileTabMoviesLoaded(movies: []));
      return;
    }

    emit(ProfileTabMoviesLoading());
    try {
      final connectivity = await Connectivity().checkConnectivity();
      final isOffline = connectivity.contains(ConnectivityResult.none);
      if (isOffline) {
        final cachedMovies = await OfflineMovieCache.loadMovies(ids);
        final offlineMovies = cachedMovies
            .map(
              (movie) => MovieModel(
                id: movie.id,
                rating: 0,
                image: AppIcons.imagePlaceholder,
                genres: const [],
                title: movie.title.isNotEmpty ? movie.title : 'Movie',
              ),
            )
            .toList();
        emit(ProfileTabMoviesLoaded(movies: offlineMovies));
        return;
      }

      final validIds = ids.where((id) => int.tryParse(id) != null).toList();
      if (validIds.isEmpty) {
        emit(ProfileTabMoviesLoaded(movies: []));
        return;
      }

      final futures = validIds
          .map((s) => _movieService.getMovieById(int.parse(s)))
          .toList();
      final details = await Future.wait(futures);
      await OfflineMovieCache.saveMovies(details);

      final movies = details
          .map(
            (d) => MovieModel(
              id: d.id,
              rating: d.rating,
              image: d.coverImage,
              genres: d.genres,
              title: d.title,
            ),
          )
          .toList();

      emit(ProfileTabMoviesLoaded(movies: movies));
    } catch (e) {
      try {
        final cachedMovies = await OfflineMovieCache.loadMovies(ids);
        if (cachedMovies.isNotEmpty) {
          final offlineMovies = cachedMovies
              .map(
                (movie) => MovieModel(
                  id: movie.id,
                  rating: 0,
                  image: AppIcons.imagePlaceholder,
                  genres: const [],
                  title: movie.title.isNotEmpty ? movie.title : 'Movie',
                ),
              )
              .toList();
          emit(ProfileTabMoviesLoaded(movies: offlineMovies));
          return;
        }
      } catch (_) {}

      emit(ProfileTabMoviesError(message: e.toString()));
    }
  }
}
