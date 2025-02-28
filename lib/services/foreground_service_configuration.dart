import 'dart:io';
import 'package:dynamictechnosoft/model/movie_model.dart';

import 'package:dynamictechnosoft/services/movie_services.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:hive/hive.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {

  late Box<Movie> movieBox;
  late MovieServices movieServices;
  
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {

   

    movieBox = await Hive.openBox<Movie>('Movie');
      await requestPermissions();
      _fetchAndStoreMovies();
  


  }
  Future<void> _fetchAndStoreMovies() async {
    try {
      // Fetch movies from API
      final nowPlaying = await movieServices.getNowPlaying();
      final popular = await movieServices.getPopular();
      final topRated = await movieServices.getTopRated();

      // Store each movie in Hive using your existing pattern
      for (var movie in [...nowPlaying, ...popular, ...topRated]) {
        if (!movieBox.containsKey(movie.id)) {
          await movieBox.put(movie.id, movie);
        }
      }
    } catch (e) {
      print('Error fetching and storing movies: $e');
    }
  }


    void myForeGroundtask() {
    FlutterForegroundTask.startService(
        notificationTitle: 'Movie App ',
        notificationText: 'Movie App is running in the background',
        callback: startCallback
        );
    // fetchAllMovies();
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



  // this functions helps to start the task
  void startForegroundTask() {
    FlutterForegroundTask.startService(
      notificationTitle: 'Movies App',
      notificationText: 'Fetching movie data...',
    );
  }

//this stops the foreground task if the app is closed
  void stopForegroundTask() {
    FlutterForegroundTask.stopService();
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



  @override
  void onRepeatEvent(DateTime timestamp) {
    // Refresh movie data periodically
    _fetchAndStoreMovies();
  }

 @override
  Future<void> onDestroy(DateTime timestamp) async {
    await movieBox.close();
  }

}


class MovieForegroundService {
  static void initializeService() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
      
        channelId: 'movie_app_foreground',
        channelName: 'Movie App Background Service',
        channelDescription: 'Keeps movie data updated in background',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        // iconData: const NotificationIconData(
        //   resType: ResourceType.mipmap,
        //   resPrefix: ResourcePrefix.ic,
        //   name: 'launcher',
        // ),
        
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(2000)     ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
     
    );
  }

  static Future<void> startService() async {
    if (await FlutterForegroundTask.isRunningService) {
      return;
    }
    
    await FlutterForegroundTask.startService(
      notificationTitle: 'Movie App',
      notificationText: 'Keeping your movie data up to date',
      callback: startCallback,
    );
  }

  static Future<void> stopService() async {
    await FlutterForegroundTask.stopService();
  }

  static Future<bool> isServiceRunning() async {
    return await FlutterForegroundTask.isRunningService;
  }
}
