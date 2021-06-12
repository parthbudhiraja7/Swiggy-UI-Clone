import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:swiggyclone/Decorations/constants.dart';
import 'package:swiggyclone/Login/phone.dart';
import 'package:swiggyclone/Login/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:swiggyclone/pages/homebottom.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String email, password;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Google Sign In Method
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;
    FirebaseFirestore.instance
        .collection("Login")
        .doc("Google Login")
        .collection(user.displayName)
        .add({
      "Email": user.email,
      "Name": user.displayName,
      "photoUrl": user.photoURL,
      "Uid": user.uid,
      "lastLogin": DateTime.now()
    });

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      return '$user';
    }

    return null;
  }

  //location
  // String _locationMessage = "";
  // void _getCurrentLocation() async {
  //   final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   print(position);

  //   setState(() {
  //     _locationMessage = "${position.latitude},${position.latitude}";
  //   });
  // }

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
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontFamily: 'OpenSans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 16.0),
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
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontWeight: FontWeight.w600,
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

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 5.0),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
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
          'LOGIN',
          style: TextStyle(
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        color: Colors.white,
        onPressed: () {
          if (_loginFormKey.currentState.validate()) {
            FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text)
                .whenComplete(() => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage())));
          }
        },
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1,
          width: 120,
          color: Colors.black,
        ),
        SizedBox(width: 10),
        Text(
          'OR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 1,
          width: 120,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildSocialBtn() {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: IconButton(
        icon: ClipOval(child: Image.asset("assets/logos/google.jpg")),
        onPressed: () {
          // _getCurrentLocation();
          signInWithGoogle().then(
            (result) {
              if (result != null) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildPhoneBtn() {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.phone),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Phone()));
        },
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                fontFamily: 'OpenSans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                vertical: 100.0,
              ),
              child: Form(
                autovalidate: false,
                key: _loginFormKey,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset("assets/logos/swiggy.png"),
                    ),
                    SizedBox(height: 20),
                    _buildEmailTF(),
                    SizedBox(height: 20),
                    _buildPasswordTF(),
                    _buildForgotPasswordBtn(),
                    _buildLoginBtn(),
                    SizedBox(height: 10),
                    _buildSignInWithText(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialBtn(),
                        SizedBox(width: 50),
                        _buildPhoneBtn(),
                      ],
                    ),
                    SizedBox(height: 40),
                    _buildSignupBtn()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
