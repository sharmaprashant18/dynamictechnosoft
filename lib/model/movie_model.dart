import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'movie_model.g.dart';

@HiveType(typeId: 2)
class Movie {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String poster_path;
  @HiveField(3)
  final String release_date;
  @HiveField(4)
  final String vote_average;

  Movie({
    required this.id,
    required this.title,
    required this.poster_path,
    required this.release_date,
    required this.vote_average,
  });
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      poster_path:
          'https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['poster_path'] ?? Image.asset('assets/loadingpage.png')}',
      release_date: json['release_date'],
      vote_average: '${json['vote_average']}',
    );
  }
}
