class SplashData {
  SplashData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
  String title;
  String subtitle;
  String imagePath;
}

List<SplashData> splashDataList = [
  SplashData(
    title: 'Welcome to',
    subtitle:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    imagePath: 'assets/green_bag.jpg',
  ),
  SplashData(
    title: 'Buy Quality Dairy Products',
    subtitle:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    imagePath: 'assets/eggs.jpg',
  ),
  SplashData(
    title: 'Buy Premium Quality Fruits',
    subtitle:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    imagePath: 'assets/lemon_bag.jpg',
  ),
  SplashData(
    title: 'Get Discounts On All Products',
    subtitle:
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy',
    imagePath: 'assets/apple.jpg',
  ),
];
