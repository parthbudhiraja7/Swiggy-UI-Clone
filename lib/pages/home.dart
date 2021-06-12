import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:swiggyclone/models/message.dart';
import 'package:swiggyclone/models/popular_brands.dart';
import 'package:swiggyclone/pages/best_in_safety_view.dart';
import 'package:swiggyclone/pages/genie/genie_view.dart';
import 'package:swiggyclone/pages/popular_categories_view.dart';
import 'package:swiggyclone/widget/custom_divider_view.dart';
import 'package:swiggyclone/widget/offersListItem.dart';
import 'package:swiggyclone/widget/ui_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:swiggyclone/pages/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> children = [
    HomeScreen(),
    Search(),
  ];

  final brands = PopularBrands.getPopularBrands();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  List offers = [
    'assets/images/offer_1.jpeg',
    'assets/images/offer_2.jpeg',
    'assets/images/offer_3.jpeg',
    'assets/images/offer_4.jpeg',
    'assets/images/offer_5.jpeg',
    'assets/images/offer_6.jpeg',
    'assets/images/offer_7.jpeg',
    'assets/images/offer_8.jpeg',
  ];
  String _locationMessage = "";
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    setState(() {
      _locationMessage = "${position.latitude},${position.latitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        leading: IconButton(
          icon: Icon(
            Icons.location_on,
            size: 30,
            color: Colors.orange[500],
          ),
          onPressed: () {
            _getCurrentLocation();
          },
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              _locationMessage,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: [
                Icon(
                  Icons.new_releases,
                  color: Color(0xff535665),
                ),
                SizedBox(width: 5),
                Text(
                  "Offers",
                  style: TextStyle(
                      color: Color(0xff535665),
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          //List For Pics
          ListView(
            children: <Widget>[
              Container(
                height: 192,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: offers.length,
                  itemBuilder: (_, index) =>
                      offersListItem(imageUrl: offers[index]),
                  separatorBuilder: (_, index) => Container(width: 5),
                ),
              ),
              //Restaurants View All
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        child: Container(
                          height: 150.0,
                          color: Colors.red.shade300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Restaurants',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(color: Colors.white),
                                    ),
                                    UIHelper.verticalSpaceExtraSmall(),
                                    Text(
                                      'No-contact delivery available',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 45.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                color: Colors.red.shade400,
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'View all',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 18.0),
                                    ),
                                    UIHelper.horizontalSpaceSmall(),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 18.0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Positioned(
                      top: -5.0,
                      right: -10.0,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/rajma.jpg',
                          width: 160.0,
                          height: 160.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              CustomDividerView(),
              //Popular Items
              Container(
                height: 230.0,
                margin: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    _buildPopularHeader(context),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: brands.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey[100],
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        brands[index].image,
                                        height: 80.0,
                                        width: 80.0,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  UIHelper.verticalSpaceSmall(),
                                  Text(
                                    brands[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  UIHelper.verticalSpace(2.0),
                                  Text(
                                    brands[index].minutes,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                            color: Colors.grey, fontSize: 13.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomDividerView(),
              GenieView(),
              CustomDividerView(),
              PopularCategoriesView(),
              CustomDividerView(),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  height: 180.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Swiper(
                    itemHeight: 100,
                    duration: 500,
                    itemWidth: double.infinity,
                    pagination: SwiperPagination(),
                    itemCount: offers.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Image.asset(
                      offers[index],
                      fit: BoxFit.cover,
                    ),
                    autoplay: true,
                    viewportFraction: 1.0,
                    scale: 0.9,
                  ),
                ),
                onTap: () {},
              ),
              CustomDividerView(),
              BestInSafetyViews(),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.all(15.0),
                height: 400.0,
                color: Colors.grey[200],
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'LIVE\nFOR\nFOOD',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.grey[400],
                                fontSize: 80.0,
                                letterSpacing: 0.2,
                                height: 0.8,
                              ),
                        ),
                        UIHelper.verticalSpaceLarge(),
                        Text(
                          'MADE BY FOOD LOVERS',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        Text(
                          'SWIGGY HQ, BANGALORE',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                        ),
                        UIHelper.verticalSpaceExtraLarge(),
                        Row(
                          children: <Widget>[
                            Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width / 4,
                              color: Colors.grey,
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      left: 140.0,
                      top: 90.0,
                      child: Image.asset(
                        'assets/images/burger.png',
                        height: 80.0,
                        width: 80.0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildPopularHeader(BuildContext context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Popular Brands',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(
              'Most ordered from around your locality',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
}
