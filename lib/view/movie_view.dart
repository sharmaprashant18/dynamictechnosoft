import 'dart:io';

import 'package:dynamictechnosoft/api.dart';
import 'package:dynamictechnosoft/model/movie_model.dart';
import 'package:dynamictechnosoft/services/foreground_service_configuration.dart';
import 'package:dynamictechnosoft/services/movie_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late Box<Movie> movieBox;

  final MovieServices movieServices = MovieServices();
  Map<String, List<Movie>> movieCategories = {
    'Now Playing': [],
    'Popular': [],
    'Top Rated': []
  };
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _initializeForegroundService();
    requestPermissions();
    startCallback();
    myForeGroundtask();

    fetchAllMovies();
    // myForeGroundtask(); //this function starts the foreground task as soon as the screen loads
  }

  void _initializeForegroundService() async {
    MovieForegroundService.initializeService();
    await MovieForegroundService.startService();
  }

  Future<void> requestPermissions() async {
    // Requesting foreground service permission (if needed for other operations)
    final NotificationPermission notificationPermission =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermission != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
    if (Platform.isAndroid) {
      if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
        // This function requires `android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS` permission.
        await FlutterForegroundTask.requestIgnoreBatteryOptimization();
        if (!await FlutterForegroundTask.canScheduleExactAlarms) {
          // When you call this function, will be gone to the settings page.
          // So you need to explain to the user why set it.
          await FlutterForegroundTask.openAlarmsAndRemindersSettings();
        }
      }
    }
  }

  void myForeGroundtask() {
    FlutterForegroundTask.startService(
        notificationTitle: 'Movie App ',
        notificationText: 'Movie App is running in the background',
        callback: startCallback);

    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
          channelImportance: NotificationChannelImportance.HIGH,
          priority: NotificationPriority.HIGH,
          showWhen: true,
          showBadge: true,
          channelId: 'movie_app_foreground',
          channelName: 'Movie app background service'),
      iosNotificationOptions: IOSNotificationOptions(),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(2000),
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<void> fetchAllMovies() async {
    setState(() {
      isLoading = true;
    });
    try {
      final nowPlaying = await movieServices.getNowPlaying();
      final popular = await movieServices.getPopular();
      final topRated = await movieServices.getTopRated();
      setState(() {
        movieCategories['Now Playing'] = nowPlaying;
        movieCategories['Popular'] = popular;
        movieCategories['Top Rated'] = topRated;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  void dispose() {
    MovieForegroundService
        .stopService(); //this stop the foreground task when the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Movie Screen',
              style: TextStyle(color: Colors.white),
            ).animate(autoPlay: true).shimmer(
                delay: Duration(milliseconds: 500),
                angle: 200,
                curve: Curves.bounceOut,
                duration: Duration(seconds: 10),
                colors: [
                  Colors.white,
                  Colors.red,
                  Colors.blue,
                  Colors.green,
                  Colors.yellow,
                  Colors.purple,
                  Colors.cyan
                ]),
            centerTitle: true,
            backgroundColor: Colors.black,
            toolbarHeight: 19,
            bottom: TabBar(
                unselectedLabelColor: Colors.white,
                labelColor: Colors.amber,
                tabs: [
                  Tab(
                      icon: Icon(Icons.movie_creation_outlined),
                      text: 'Now Playing'),
                  Tab(icon: Icon(Icons.star), text: 'Popular')
                      .animate()
                      .shimmer(),
                  Tab(icon: Icon(Icons.star_rate), text: 'Top Rated'),
                ]),
          ),
          body: isLoading
              ? Center(
                  child: Shimmer.fromColors(
                      child: Text(''),
                      baseColor: Colors.red,
                      highlightColor: Colors.red))
              : TabBarView(children: [
                  MovieGridView(movies: movieCategories['Now Playing'] ?? []),
              //         .animate()
              //         .shimmer(colors: [
              // Colors.transparent,
              //       Colors.red,
              //       Colors.blue,
              //       Colors.green,
              //       Colors.yellow,
              //       Colors.purple,
              //       Colors.cyan
                    
              //     ]),
                  MovieGridView(movies: movieCategories['Popular'] ?? []),
                  //     .animate(
                  //       autoPlay: true
                  //     )
                  //     .shimmer(

                  //       colors: [
                  //          Colors.transparent,
                  //   Colors.red,
                  //   Colors.blue,
                  //   Colors.green,
                  //   Colors.yellow,
                  //   Colors.purple,
                  //   Colors.cyan
                  // ]),
                  MovieGridView(movies: movieCategories['Top Rated'] ?? []),
                  //     .animate()
                  //     .shimmer(colors: [
                  //          Colors.transparent,
                  //   Colors.red,
                  //   Colors.blue,
                  //   Colors.green,
                  //   Colors.yellow,
                  //   Colors.purple,
                  //   Colors.cyan
                  // ]),
                ])),
    );
  }
}

class MovieGridView extends StatelessWidget {
  final List<Movie> movies;
  MovieGridView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 5,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        // return MovieCard(movie: movie);
        return Card(
          
          surfaceTintColor: Colors.red,
          shadowColor: Colors.amber,
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  '${ApiConstants.imageBaseUrl}${movie.poster_path}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          double.parse(movie.vote_average).toStringAsFixed(1),
                          //if the type is in string and needed fixed string with the double value then it is done
                          style: const TextStyle(fontSize: 12),
                        ),
                        // Text(movie.id),
                        SizedBox(width: 30),
                        Icon(
                          Icons.watch_later_outlined,
                          size: 14,
                        ),
                        Text(
                          movie.release_date,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}




// class MovieCard extends StatelessWidget {
//   final Movie movie;

//   const MovieCard({
//     Key? key,
//     required this.movie,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       surfaceTintColor: Colors.red,

//       elevation: 4,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Image.network(
//               '${ApiConstants.imageBaseUrl}${movie.poster_path}',
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Center(
//                   child: Icon(Icons.error),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   movie.title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.star, size: 16, color: Colors.amber),
//                     const SizedBox(width: 4),
//                     Text(
//                       movie.vote_average,
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                     SizedBox(width: 30),
//                     Icon(
//                       Icons.watch_later_outlined,
//                       size: 14,
//                     ),
//                     Text(
//                       movie.release_date,
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


