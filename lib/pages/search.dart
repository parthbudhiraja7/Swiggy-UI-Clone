import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            TextFormField(
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF3d4152),
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFa9abb2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFa9abb2),
                  ),
                ),
                hintText: 'Search for restaurants and food',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3d4152),
                  fontWeight: FontWeight.w600,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFa9abb2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
