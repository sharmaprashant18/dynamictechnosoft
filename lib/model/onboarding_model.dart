class OnboardingModel {
  final String title;
  final String description;
  final String image;
  OnboardingModel(
      {required this.title, required this.description, required this.image});
  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
        title: json['title'],
        description: json['description'],
        image: json['image']);
  }
}

final pages = [
  {
    'title': 'Welcome to the app',
    'description': 'This is the welcome screen',
    'image': 'assets/onboardingpage1.png'
  },
  {
    'title': 'Welcome to the second onboarding sceen',
    'description': 'This is the second onboarding sceen.',
    'image': 'assets/onboardingpage2.png'
  },
  {
    'title': 'Welcome to the third onboarding sceen',
    'description': 'This is the third onboarding sceen.',
    'image': 'assets/onboardingpage3.png'
  }
];
List<OnboardingModel> pagesData =
    pages.map((e) => OnboardingModel.fromJson(e)).toList();
