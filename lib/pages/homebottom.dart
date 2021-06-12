import 'package:flutter/material.dart';
import 'package:swiggyclone/pages/account.dart';
import 'package:swiggyclone/pages/cart.dart';
import 'package:swiggyclone/pages/home.dart';
import 'package:swiggyclone/pages/search.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Widget _body;

  @override
  void initState() {
    super.initState();

    this._body = HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('SWIGGY'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('SEARCH'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _setBodyLayout();
  }

  void _setBodyLayout() {
    switch (_selectedIndex) {
      case 0:
        setState(() => _body = HomeScreen());
        break;

      case 1:
        setState(() => _body = Search());
        break;

      case 2:
        setState(() => _body = Cart());
        break;

      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Account(),
            ));
        _onItemTapped(0);
        break;
    }
  }
}
