class OnboardingContent{

  String headerImage;
  String contentImage;
  String headerText;
  String descText;

  OnboardingContent({required this.headerImage, required this.contentImage, required this.headerText, required this.descText});
}

List<OnboardingContent> contents=[

  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_1.png',
      headerText: "Open mini account\n #your daily use account",
      descText: ""),
  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_2.png',
      headerText: "Get instant AntPay digital card with offer on 200+ brands",
      descText: ""),
  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_3.png',
      headerText: "Take hassle free loans at AntPay",
      descText: ""),
  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_4.png',
      headerText: "Insure yourself and your family",
      descText: ""),
  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_5.png',
      headerText: "Start Saving Money",
      descText: ""),
  OnboardingContent(
      headerImage: 'assets/images/antpay_logo.png',
      contentImage: 'assets/images/img_intro_6.png',
      headerText: "Managing finances has never been so easy\n #neo bank for all",
      descText: "")

];