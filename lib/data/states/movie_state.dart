import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:procom_kas/data/models/movie_model.dart';
import 'package:procom_kas/services/movie_service.dart';

class MovieState {
  final List<MovieModel>? data;
  final bool isLoading;
  final String? errorMessage;

  MovieState({this.data, this.isLoading = false, this.errorMessage});

  MovieState copyWith({
    List<MovieModel>? data,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MovieState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class MovieNotifier extends StateNotifier<MovieState> {
  final MovieService _movieService = MovieService();

  MovieNotifier() : super(MovieState());

  Future<void> getMovie() async {
    state = state.copyWith(isLoading: true);
    final result = await _movieService.fetchMovies();
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        data: result.data,
        errorMessage: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result.error,
      );
    }
  }
}

final movieNotifierProvider =
    StateNotifierProvider<MovieNotifier, MovieState>((ref) {
  return MovieNotifier();
});
