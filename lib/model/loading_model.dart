class DownloadModel {
  final bool isLoading;
  final double progress;

  DownloadModel({this.isLoading = false, this.progress = 0.0});

  DownloadModel copyWith({bool? isLoading, double? progress}) {
    return DownloadModel(
      isLoading: isLoading ?? this.isLoading,
      progress: progress ?? this.progress,
    );
  }
}
