class OnboardingContent {
  String image = "a";
  String title = "b";
  String description = "c";

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Notes',
      image: 'assets/images/onboarding1.png',
      description: "Lorem ipsum planting sit amet."),
  OnboardingContent(
      title: 'Notes',
      image: 'assets/images/onboarding2.png',
      description: "Lorem ipsum selling sit amet."),
  OnboardingContent(
      title: 'Notes ',
      image: 'assets/images/onboarding3.png',
      description: "Lorem ipsum teaching sit amet."),
];
