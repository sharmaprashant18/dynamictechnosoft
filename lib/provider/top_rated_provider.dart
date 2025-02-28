
// import 'package:dynamictechnosoft/api.dart';
// import 'package:dynamictechnosoft/provider/movie_state.dart';
// import 'package:dynamictechnosoft/provider/nowplaying_provider.dart';
// import 'package:dynamictechnosoft/services/movie_services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final topRatedProvider =
//     StateNotifierProvider<NowPlayingNotifier, MovieState>((ref) {
//   return NowPlayingNotifier();
// });

// class TopRatedNotifier extends StateNotifier<MovieState> {
//   TopRatedNotifier()
//       : super(MovieState(
//           isLoading: false,
//           movies: [],
//           error: '',
//           apiPath: Api.nowPlaying,
//           page: 1,
//           loadMore: false,
//         )) {
//     getMovies();
//   }

//   Future<void> getMovies() async {
//     state = state.copyWith(isLoading: true, error: '');
//     try {
//       final movies = await MovieServices.getMovieByCategory(
//         apiPath: state.apiPath,
//         page: state.page,
//       );
//       state = state.copyWith(
//         isLoading: false,
//         movies: [...state.movies, ...movies],
//         loadMore: false,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//         loadMore: false,
//       );
//     }
//   }

//   void changeMovieCategory(String newApiPath) {
//     state = state.copyWith(
//       apiPath: newApiPath,
//       movies: [],
//       page: 1,
//       error: '',
//     );
//     getMovies();
//   }

//   void loadMoreMovies() {
//     if (!state.isLoading && !state.loadMore) {
//       state = state.copyWith(
//         page: state.page + 1,
//         loadMore: true,
//       );
//       getMovies();
//     }
//   }
// }