import 'package:flutter/foundation.dart';

class SpotlightBestTopFood {
  final String image;
  final String name;
  final String desc;
  final String coupon;
  final String ratingTimePrice;

  SpotlightBestTopFood({
    @required this.image,
    @required this.name,
    @required this.desc,
    @required this.coupon,
    @required this.ratingTimePrice,
  });

  static List<List<SpotlightBestTopFood>> getBestRestaurants() {
    return [
      [
        SpotlightBestTopFood(
          image: 'assets/logos/subway.jfif',
          name: 'Subway',
          desc: 'Fast Food, Healthy Food',
          coupon: '30 \$ off | Use JUMBO',
          ratingTimePrice: '4.1 21 mins - Rs 350 for two',
        ),
        SpotlightBestTopFood(
          image: 'assets/logos/cafeteria.jfif',
          name: 'Cafeteria & Co.',
          desc: 'Italian, American, Continental',
          coupon: '20 \$ off | Use JUMBO',
          ratingTimePrice: '4.1 33 mins - Rs 600 for two',
        ),
      ],
      [
        SpotlightBestTopFood(
          image: 'assets/logos/crust.jfif',
          name: 'Mr. Crust Bakers',
          desc: 'Desert, Fast Food, Bakery',
          coupon: '20 \$ off | Use JUMBO',
          ratingTimePrice: '4.3 26 mins - Rs 400 for two',
        ),
        SpotlightBestTopFood(
          image: 'assets/logos/rasoi.jpg',
          name: 'Apni Rasoi',
          desc: 'North Indian, Chinese, Snacks',
          coupon: '30 \$ off | Use A2BSUPER',
          ratingTimePrice: '4.0 20 mins - Rs 250 for two',
        ),
      ],
      [
        SpotlightBestTopFood(
          image: 'assets/logos/italio.jfif',
          name: 'Italio By Hudson',
          desc: 'Italian, Pizzas, Pastas',
          coupon: '30 \$ off | Use JUMBO',
          ratingTimePrice: '4.2 27 mins - Rs 250 for two',
        ),
        SpotlightBestTopFood(
          image: 'assets/logos/shagun.jpg',
          name: 'Shagun',
          desc: 'Chinese, Thai, Japanese, Tibetan',
          coupon: '20 \$ off | Use SWIGGYIT',
          ratingTimePrice: '4.0 30 mins - Rs 300 for two',
        ),
      ],
      [
        SpotlightBestTopFood(
          image: 'assets/images/dominoz.png',
          name: "Domino's Pizza",
          desc: 'Pizzas',
          coupon: '20 \$ off | Use JUMBO',
          ratingTimePrice: '4.0 30 mins - Rs 400 for two',
        ),
        SpotlightBestTopFood(
          image: 'assets/logos/pizza.jpeg',
          name: 'Pizza Hut',
          desc: "Pizzas, Fast Food",
          coupon: '30 \$ off | Use JUMBO',
          ratingTimePrice: '3.8 33 mins - Rs 350 for two',
        ),
      ]
    ];
  }
}
