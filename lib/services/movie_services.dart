import 'package:dio/dio.dart';
import 'package:dynamictechnosoft/api.dart';
import 'package:dynamictechnosoft/model/movie_model.dart';
import 'package:hive/hive.dart';

class MovieServices {
  final Dio dio = Dio();
  final Box<Movie> movieBox = Hive.box<Movie>('Movie'); // Open Hive Box
  Future<List<Movie>> getMovieByCategory(String apiPath) async {
    try {
       if (movieBox.isNotEmpty) {
        return movieBox.values.toList();
      }
      final response = await dio.get('${ApiConstants.baseUrl}$apiPath',
          queryParameters: {'api_key': 'f370a118f8c9551e6f47b9193d032054'});
      if (response.statusCode == 200) {
        final datas = response.data;
        final movieData =
            (datas['results'] as List).map((e) => Movie.fromJson(e)).toList();
               await movieBox.clear(); // Clear old data
        await movieBox.addAll(movieData);
        return movieData;
      } else {
        throw Exception('Unable to fetch movie');
      }
    } catch (e) {
      throw Exception('Error:$e');
    }
  }

  Future<List<Movie>> getNowPlaying() async {
    return getMovieByCategory(ApiConstants.nowPlaying);
  }

  Future<List<Movie>> getTopRated() async {
    return getMovieByCategory(ApiConstants.topRated);
  }

  Future<List<Movie>> getPopular() async {
    return getMovieByCategory(ApiConstants.popular);
  }
}


