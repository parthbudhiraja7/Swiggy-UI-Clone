import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swiggyclone/models/spotlight_best_top_food.dart';
import 'package:swiggyclone/pages/restaurant_detail_screen.dart';
import 'package:swiggyclone/widget/ui_helper.dart';

class SpotlightBestTopFoodItem extends StatelessWidget {
  final SpotlightBestTopFood restaurant;

  const SpotlightBestTopFoodItem({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDetailScreen(),
          ),
        );
      },
      // child: StreamBuilder(
      //   stream:
      //       FirebaseFirestore.instance.collection('Restaurants').snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.data == null) return CircularProgressIndicator();
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: snapshot.data.docs.length,
      //       itemBuilder: (context, index) {
      //         DocumentSnapshot rest = snapshot.data.docs[index];
      //         return Container(
      //           margin: const EdgeInsets.all(15.0),
      //           child: Row(
      //             children: <Widget>[
      //               Container(
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10.0),
      //                   color: Colors.white,
      //                   boxShadow: <BoxShadow>[
      //                     BoxShadow(
      //                       color: Colors.grey,
      //                       blurRadius: 2.0,
      //                     )
      //                   ],
      //                 ),
      //                 child: Image.network(
      //                   rest["image"],
      //                   height: 100.0,
      //                   width: 100.0,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //               UIHelper.horizontalSpaceSmall(),
      //               Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   Text(
      //                     rest["name"],
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .subtitle2
      //                         .copyWith(fontSize: 18.0),
      //                   ),
      //                   Text(rest["desc"],
      //                       style: Theme.of(context)
      //                           .textTheme
      //                           .bodyText1
      //                           .copyWith(
      //                               color: Colors.grey[800], fontSize: 13.5)),
      //                   UIHelper.verticalSpaceSmall(),
      //                   Text(
      //                     rest["coupon"],
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .bodyText1
      //                         .copyWith(color: Colors.red[900], fontSize: 13.0),
      //                   ),
      //                   UIHelper.verticalSpaceExtraSmall(),
      //                   UIHelper.verticalSpaceExtraSmall(),
      //                   Row(
      //                     children: <Widget>[
      //                       Icon(
      //                         Icons.star,
      //                         size: 14.0,
      //                         color: Colors.grey[600],
      //                       ),
      //                       Text(rest["ratingTimePrice"])
      //                     ],
      //                   )
      //                 ],
      //               )
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      child: Container(
        margin: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                  )
                ],
              ),
              child: Image.asset(
                restaurant.image,
                height: 100.0,
                width: 100.0,
                fit: BoxFit.cover,
              ),
            ),
            UIHelper.horizontalSpaceSmall(),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  restaurant.name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 18.0),
                ),
                Text(restaurant.desc,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey[800], fontSize: 13.5)),
                UIHelper.verticalSpaceSmall(),
                Text(
                  restaurant.coupon,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.red[900], fontSize: 13.0),
                ),
                UIHelper.verticalSpaceExtraSmall(),
                UIHelper.verticalSpaceExtraSmall(),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      size: 14.0,
                      color: Colors.grey[600],
                    ),
                    Text(restaurant.ratingTimePrice)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
