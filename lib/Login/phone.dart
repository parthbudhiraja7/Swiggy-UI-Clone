import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swiggyclone/pages/homebottom.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  // void _moveBack() => Navigator.pop(context);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationCode;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String _verificationId, number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Container(
            height: 160,
            width: double.infinity,
            color: Color.fromRGBO(211, 219, 234, 0.3),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.only(right: 24),
                  child: Image(
                    image: AssetImage('assets/logos/create_account.png'),
                    height: 134,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          color: Color.fromRGBO(40, 44, 63, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          "Enter your phone number to continue",
                          style: TextStyle(
                            color: Color(0xff7e808c),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.arrow_back),
                  ),
                  // onTap: _moveBack,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        number = value;
                      });
                    },
                    controller: _phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'PHONE NUMBER',
                      // labelText: 'Phone number (+xx xxx-xxx-xxxx)',
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: RaisedButton(
                      color: Color(0xFFe46d47),
                      child: Text(
                        "GENERATE OTP",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        verifyPhoneNumber();
                        uploadData(context);
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _smsController,
                    decoration:
                        const InputDecoration(labelText: 'VERIFICATION CODE'),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: RaisedButton(
                      color: Color(0xFFe46d47),
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithCredential(
                                  PhoneAuthProvider.credential(
                                      verificationId: _verificationCode,
                                      smsCode: _smsController.text))
                              .then(
                            (value) async {
                              if (value.user != null) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyHomePage(),
                                    ),
                                    (route) => false);
                              }
                            },
                          );
                        } catch (e) {
                          FocusScope.of(context).unfocus();
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text('invalid OTP'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void verifyPhoneNumber() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumberController.text,
        timeout: Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
      );
    } catch (e) {
      print("Failed to Verify Phone Number: ${e.message}");
    }
  }

  Future uploadData(BuildContext context) async {
    FirebaseFirestore.instance
        .collection("Login")
        .doc("Phone Login")
        .collection(number)
        .add({"Mobile Number": number, "Registeration Time": DateTime.now()});
  }
}
