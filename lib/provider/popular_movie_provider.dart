// import 'package:dynamictechnosoft/api.dart';
// import 'package:dynamictechnosoft/provider/movie_state.dart';
// import 'package:dynamictechnosoft/services/movie_services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final popularNotifier = StateNotifierProvider<PopularNotifier, MovieState>(
//     (ref) => PopularNotifier());

// class PopularNotifier extends StateNotifier<MovieState> {
//   PopularNotifier()
//       : super(MovieState(
//             error: '',
//             movies: [],
//             isLoading: false,
//             apiPath: Api.popularMovie,
//             page: 1,
//             loadMore: false));
//   Future<void> getMovies() async {
//     state = state.copyWith(
//       isLoading: true,
//       error: '',
//       loadMore: false,
//       movies: [],
//       page: 1,
//     );
//     try {
//       final movies = await MovieServices.getMovieByCategory(
//           apiPath: Api.popularMovie, page: state.page);
//       state = state.copyWith(
//           isLoading: false,
//           movies: [...state.movies, ...movies],
//           loadMore: false);
//     } catch (e) {
//       state = state.copyWith(
//           isLoading: false, error: e.toString(), loadMore: false);
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
