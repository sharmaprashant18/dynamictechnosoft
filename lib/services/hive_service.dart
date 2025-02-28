import 'package:dynamictechnosoft/model/counter_model.dart';
import 'package:dynamictechnosoft/model/hive_model.dart';
import 'package:dynamictechnosoft/model/movie_model.dart';
import 'package:hive_flutter/adapters.dart';

class MyHiveService {
  late Box settingsBox;
  late Box<Movie> movieBox;
  Future<void> init() async {
    //register all adapter here
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(CounteAdapter());
    Hive.registerAdapter(MovieAdapter());

    //open boxes
    await Hive.openBox<User>('user_credential');
    await Hive.openBox<Counte>('counting');
    await Hive.openBox('Settings');
    movieBox = await Hive.openBox<Movie>('Movie');
  }

  //Add a movie
  Future<void> addMovie(Movie movie) async {
    await movieBox.put(movie.id, movie);
  }

  // Future<void> addMovies(List<Movie> movies) async {
  //   final moviesMap = {for (var movie in movies) movie.id: movie};
  //   await movieBox.putAll(moviesMap);
  // }
//Get all Movies
  List<Movie> getAllMovies() {
    return movieBox.values.toList();
  }

//Get a specific movie by id
  Movie? getMovie(int id) {
    return movieBox.get(id);
  }

//Delete a movie by id
  Future<void> deleteMovie(int id) async {
    await movieBox.delete(id);
  }

//Clear all movies
  Future<void> clearMovies() async {
    await movieBox.clear();
  }

  bool hasMovie(int id) {
    return movieBox.containsKey(id);
  }


}
