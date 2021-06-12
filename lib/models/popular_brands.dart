import 'package:flutter/foundation.dart';

class PopularBrands {
  final String image;
  final String name;
  final String minutes;

  PopularBrands({
    @required this.image,
    @required this.name,
    @required this.minutes,
  });

  static List<PopularBrands> getPopularBrands() {
    return [
      PopularBrands(
          image: 'assets/images/dominoz.png',
          name: "Domino's",
          minutes: '25 mins'),
      PopularBrands(
          image: 'assets/images/subway.png',
          name: 'Subway',
          minutes: '32 mins'),
      PopularBrands(
          image: 'assets/images/burgerking.jpg',
          name: 'Burger King',
          minutes: '26 mins'),
      PopularBrands(
        image: 'assets/images/kfc.png',
        name: 'KFC',
        minutes: '35 mins',
      ),
      PopularBrands(
          image: 'assets/images/haldiram.png',
          name: 'Haldiram',
          minutes: '22 mins'),
      PopularBrands(
          image: 'assets/images/sagar.png',
          name: 'Sagar Ratna',
          minutes: '31 mins'),
    ];
  }
}
