import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiggyclone/models/restaurant_detail.dart';
import 'package:swiggyclone/pages/cart.dart';
import 'package:swiggyclone/widget/custom_divider_view.dart';
import 'package:swiggyclone/widget/dotted_seperator_view.dart';
import 'package:swiggyclone/widget/ui_helper.dart';
import 'package:swiggyclone/widget/veg_badge_view.dart';

class RestaurantDetailScreen extends StatelessWidget {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //firestore vars
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.red.shade500,
            ),
            UIHelper.horizontalSpaceSmall(),
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ),
                );
              },
            ),
            UIHelper.horizontalSpaceSmall(),
          ],
          bottom: TabBar(
            indicatorColor: Colors.black,
            tabs: <Widget>[
              Tab(
                  child: Text(
                'Order Now',
                style: TextStyle(
                    color: Color(0xff535665),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500),
              )),
              Tab(
                child: Text(
                  'Safety Standards',
                  style: TextStyle(
                      color: Color(0xff535665),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _OrderNowView(),
            _SafetyStandardsView(),
          ],
        ),
      ),
    );
  }
}

class _OrderNowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('subway').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: Text("Loading.."));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        snapshot.data.documents[0]['Company'],
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      UIHelper.verticalSpaceSmall(),
                      Text(
                        snapshot.data.documents[0]['Description'],
                        style: TextStyle(
                            color: Color(0xff535665),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700),
                      ),
                      UIHelper.verticalSpaceExtraSmall(),
                      Text(
                        snapshot.data.documents[0]['Location'],
                        style: TextStyle(
                            color: Color(0xff535665),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700),
                      ),
                      UIHelper.verticalSpaceMedium(),
                      DottedSeperatorView(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _buildVerticalStack(
                              context,
                              snapshot.data.documents[0]['rating'].toString(),
                              'Packaging 80%'),
                          _buildVerticalStack(
                              context,
                              snapshot.data.documents[0]['time'],
                              'Delivery Time'),
                          _buildVerticalStack(
                              context,
                              'Rs ' +
                                  snapshot.data.documents[0]['cost'].toString(),
                              'Cost for 2'),
                        ],
                      ),
                      DottedSeperatorView(),
                      UIHelper.verticalSpaceMedium(),
                      Column(
                        children: <Widget>[
                          _buildOfferTile(context,
                              '30% off up to Rs75 | Use code SWIGGYIT'),
                          _buildOfferTile(context,
                              '20% off up to Rs100 with SBI credit cards, once per week | Use code 100SBI')
                        ],
                      ),
                      UIHelper.verticalSpaceSmall(),
                    ],
                  ),
                ),
                CustomDividerView(dividerHeight: 15.0),
                Container(
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.filter_vintage,
                                color: Colors.green, size: 12.0),
                            UIHelper.horizontalSpaceExtraSmall(),
                            Text('PURE VEG',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0))
                          ],
                        ),
                      ),
                      CustomDividerView(dividerHeight: 0.5, color: Colors.black)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Recommended',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('subway')
                      .doc('FoodItems')
                      .collection('menu')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot food = snapshot.data.docs[index];
                        return Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image.network(
                                food['img'],
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                              UIHelper.verticalSpaceExtraSmall(),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      VegBadgeView(),
                                      UIHelper.horizontalSpaceExtraSmall(),
                                      Text(
                                        food['recommendation'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              fontSize: 12.0,
                                              color: Colors.red[500],
                                            ),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceExtraSmall(),
                                  UIHelper.verticalSpaceExtraSmall(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        food['desc'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(fontSize: 15.0),
                                      ),
                                      UIHelper.verticalSpaceExtraSmall(),
                                      Text(
                                        food['offer'],
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceMedium(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("₹" + food['price'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 15.0)),
                                      AddBtnView()
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                CustomDividerView(dividerHeight: 15.0),
                Container(
                  height: 80.0,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'BFF Combos',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 18.0),
                        ),
                      ),
                      CustomDividerView(dividerHeight: 0.5, color: Colors.black)
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('subway')
                      .doc('FoodItems')
                      .collection('submenu')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null)
                      return CircularProgressIndicator();
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot subfood = snapshot.data.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 25, top: 5, bottom: 20),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        VegBadgeView(),
                                        UIHelper.horizontalSpaceExtraSmall(),
                                        Text(
                                          subfood['recommend'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                fontSize: 12.0,
                                                color: Colors.red[500],
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      subfood['Item'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Text("₹" + subfood['price'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 15.0)),
                                    SizedBox(height: 5),
                                    Text(
                                      subfood['desc'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                AddBtnView()
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding _buildOfferTile(BuildContext context, String desc) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.new_releases, color: Colors.red[500], size: 15.0),
            UIHelper.horizontalSpaceSmall(),
            Flexible(
              child: Text(
                desc,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 13.0),
              ),
            )
          ],
        ),
      );

  Container _buildVerticalStack(
          BuildContext context, String title, String subtitle) =>
      Container(
        height: 60.0,
        width: (MediaQuery.of(context).size.width / 3) - 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 15.0),
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Text(subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 13.0))
          ],
        ),
      );
}

class AddBtnView extends StatelessWidget {
  const AddBtnView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
      ),
      child: FlatButton(
        onPressed: () {},
        child: Text(
          'ADD',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ),
    );
  }
}

class _FoodListView extends StatelessWidget {
  final String title;
  final List<RestaurantDetail> foods;

  const _FoodListView({
    Key key,
    @required this.title,
    @required this.foods,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          UIHelper.verticalSpaceMedium(),
          Text(
            title,
            style:
                Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 18.0),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: foods.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      VegBadgeView(),
                      UIHelper.horizontalSpaceMedium(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              foods[index].title,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            UIHelper.verticalSpaceSmall(),
                            Text(
                              foods[index].price,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 14.0),
                            ),
                            UIHelper.verticalSpaceMedium(),
                            foods[index].desc != null
                                ? Text(
                                    foods[index].desc,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 5.0,
                                          color: Colors.grey[500],
                                        ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      AddBtnView()
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SafetyStandardsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('Work In Progress',
          style: Theme.of(context).textTheme.subtitle2),
    );
  }
}
