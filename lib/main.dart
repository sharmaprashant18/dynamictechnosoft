import 'package:dynamictechnosoft/provider/switch_color_provider.dart';
import 'package:dynamictechnosoft/services/hive_service.dart';
import 'package:dynamictechnosoft/view/child_page_for%20lock%20screen.dart';
import 'package:dynamictechnosoft/view/custom_paint.dart';
import 'package:dynamictechnosoft/view/liner_progress_indicator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initializing Firebase
  Firebase.initializeApp();

  //Initialize Hive Flutter
  await Hive.initFlutter();
  FlutterForegroundTask.initCommunicationPort();

  //initialize my hive service
  final hiveService = MyHiveService();
  await hiveService.init();

  runApp(ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarMode = ref.watch(themeProvider);
    return MaterialApp(
// debugShowCheckedModeBanner: kDebugMode? true:false,
      debugShowCheckedModeBanner: false,
      home: 2 == 3
          ? LinerProgressPage(
              title: 'Loading.....',
              backgroundColors: isDarMode ? Colors.black : Colors.pink,
              foregroundColors: isDarMode ? Colors.pink : Colors.green,
              showLinear: true,
            )
          : CustomPaintPage(
              child: PermissionScreen(),
            ),

      theme: ThemeData(
        fontFamily: "Montserrat",
      ),
      darkTheme: ThemeData.dark(),
      themeMode: isDarMode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}


