// // import 'package:dynamictechnosoft/api.dart';
// // import 'package:dynamictechnosoft/provider/movie_state.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import 'package:dynamictechnosoft/services/movie_services.dart';

// // // Provider for MovieNotifier
// // final movieProvider =
// //     StateNotifierProvider.autoDispose<MovieNotifier, MovieState>((ref) {
// //   return MovieNotifier(
// //     MovieState(
// //       error: '',
// //       movies: [],
// //       isLoading: false,
// //       apiPath: Api.popularMovie,
// //       page: 1,
// //       loadMore: false,
// //     ),
// //   );
// // });

// // class MovieNotifier extends StateNotifier<MovieState> {
// //   MovieNotifier(MovieState state) : super(state) {
// //     getMovies();
// //   }

// //   Future<void> getMovies() async {
// //     if (state.loadMore) {
// //       // Don't fetch if already loading more
// //       return;
// //     }

// //     // Set loading state
// //     state = state.instances(
// //       movieState: state,
// //       isLoading: true,
// //       loadMore: true,
// //     );

// //     try {
// //       final movies = await MovieServices.getMovie(
// //         apiPath: state.apiPath,
// //         page: state.page,
// //       );

// //       if (movies != null) {
// //         // Update state with new movies
// //         state = state.instances(
// //           movieState: state,
// //           movies: [...state.movies, ...movies],
// //           isLoading: false,
// //           error: '',
// //           loadMore: false,
// //         );
// //       }
// //     } catch (e) {
// //       // Update state with error
// //       state = state.instances(
// //         movieState: state,
// //         isLoading: false,
// //         error: e.toString(),
// //         loadMore: false,
// //       );
// //     }
// //   }

// //   // Change movie category and reset state
// //   void changeMovieCategory(String newApiPath) {
// //     state = MovieState(
// //       error: '',
// //       movies: [],
// //       isLoading: false,
// //       apiPath: newApiPath,
// //       page: 1,
// //       loadMore: false,
// //     );
// //     getMovies();
// //   }

// //   // Load next page
// //   void loadMoreMovies() {
// //     if (!state.isLoading && !state.loadMore) {
// //       state = state.instances(
// //         movieState: state,
// //         page: state.page + 1,
// //       );
// //       getMovies();
// //     }
// //   }
// // }

// // // // Read the movie state
// // // final movieState = ref.watch(movieProvider);

// // // // Load more movies
// // // ref.read(movieProvider.notifier).loadMoreMovies();

// // // // Change movie category
// // // ref.read(movieProvider.notifier).changeMovieCategory(Api.topRatedMovie);

// import 'package:dynamictechnosoft/api.dart';
// import 'package:dynamictechnosoft/provider/movie_state.dart';
// import 'package:dynamictechnosoft/services/movie_services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final nowPlayingProvider =
//     StateNotifierProvider<NowPlayingNotifier, MovieState>((ref) {
//   return NowPlayingNotifier();
// });

// class NowPlayingNotifier extends StateNotifier<MovieState> {
//   NowPlayingNotifier()
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

