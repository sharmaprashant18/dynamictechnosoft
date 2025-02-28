// api_constants.dart
class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  static const String nowPlaying = '/movie/now_playing';
  static const String topRated = '/movie/top_rated';
  static const String popular = '/movie/popular';
}

// singleton example

// class ApiConstants {
//   static final ApiConstants _instance = ApiConstants._internal();

//   factory ApiConstants() {
//     return _instance;
//   }

//   ApiConstants._internal(); // Private constructor

//   static const String baseUrl = 'https://api.themoviedb.org/3';
//   static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
//   static const String nowPlaying = '/movie/now_playing';
//   static const String topRated = '/movie/top_rated';
//   static const String popular = '/movie/popular';
// }
