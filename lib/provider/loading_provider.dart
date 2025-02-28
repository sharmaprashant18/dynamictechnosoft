// StateNotifier to handle logic
import 'dart:async';

import 'package:dynamictechnosoft/model/loading_model.dart';
import 'package:dynamictechnosoft/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DownloadNotifier extends StateNotifier<DownloadModel> {
  DownloadNotifier() : super(DownloadModel());
  // ignore: unused_field
  Timer? _timer;
  void startDownload(BuildContext context) {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, progress: 0.0);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.progress >= 1.0) {
        timer.cancel();
        state = state.copyWith(isLoading: false);
        _navigateToHome(context);
      } else {
        state = state.copyWith(progress: state.progress + 0.05);
      }
    });
  }
  void cancelDownload() {
    _timer?.cancel();
    state = state.copyWith(isLoading: false, progress: 0.0);
  }
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

}

// Riverpod provider
final downloadProvider = StateNotifierProvider<DownloadNotifier, DownloadModel>(
    (ref) => DownloadNotifier());



