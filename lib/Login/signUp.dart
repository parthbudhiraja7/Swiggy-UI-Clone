import 'package:flutter/material.dart';
import 'package:swiggyclone/Decorations/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swiggyclone/Login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  String email, password, name, number;

  Future uploadData(BuildContext context) async {
    FirebaseFirestore.instance
        .collection("Login")
        .doc("Email Login")
        .collection(name)
        .add({
      "Name": nameController.text,
      "Mobile Number": number,
      "Email": emailController.text,
      "Password": password,
      "Registeration Time": DateTime.now()
    });
  }

  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Your Name";
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 17.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.black54,
              ),
              hintText: 'Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: phoneController,
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Your Mobile Number";
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {
                number = value;
              });
            },
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 17.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.black54,
              ),
              hintText: 'Mobile Number',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  //Validate Email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: emailController,
            validator: validateEmail,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            style: TextStyle(color: Colors.black, fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 17.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black54,
              ),
              hintText: 'Email Address',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            controller: passwordController,
            validator: (value) {
              if (value.isEmpty) {
                return "Enter Your Password";
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 17.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black54,
              ),
              hintText: 'Enter Your Password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      child: RaisedButton(
        elevation: 3.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          'Register',
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        color: Colors.white,
        onPressed: () {
          if (_registerFormKey.currentState.validate()) {
            FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                .whenComplete(() => uploadData(context))
                .whenComplete(() => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login())));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 80.0,
              ),
              child: Form(
                autovalidate: false,
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Image.asset("assets/logos/swiggy.png"),
                    ),
                    SizedBox(height: 20),
                    _buildNameTF(),
                    SizedBox(height: 20),
                    _buildPhoneTF(),
                    SizedBox(height: 20),
                    _buildEmailTF(),
                    SizedBox(height: 20),
                    _buildPasswordTF(),
                    SizedBox(height: 10),
                    _buildRegisterBtn()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
