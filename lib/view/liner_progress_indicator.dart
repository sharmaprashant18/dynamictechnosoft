import 'package:dynamictechnosoft/provider/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LinerProgressPage extends ConsumerWidget {
  LinerProgressPage({
    required this.title,
    required this.backgroundColors,
    required this.foregroundColors,
    required this.showLinear,
  });

  final String title;
  final Color backgroundColors;
  final Color foregroundColors;
  final bool showLinear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadState = ref.watch(downloadProvider);
    final downloadNotifier = ref.read(downloadProvider.notifier);
    Future.microtask(() {
      if (!downloadState.isLoading) {
        downloadNotifier.startDownload(context);
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/loadingpage.png'),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          downloadState.isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/loadingpage.png'),
                              fit: BoxFit.fitHeight)),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 350),
                            child: CircularProgressIndicator(
                              value: downloadState.progress,
                              backgroundColor:backgroundColors,
                              strokeWidth: 8,
                              valueColor: AlwaysStoppedAnimation(Colors.green),
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            '${title} ${(downloadState.progress * 100).round()}%',
                            style: TextStyle(fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 400),
                            child: LinearProgressIndicator(
                              value: downloadState.progress,
                              backgroundColor: backgroundColors,
                              minHeight: 15,
                              valueColor: AlwaysStoppedAnimation(Colors.black),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                          ),
                          Text(
                              '${title}${(downloadState.progress * 100).round()}%')
                        ],
                      ),
                    ),
                  ],
                )
              : Text(''),
        ],
      ),
    );
  }
}



