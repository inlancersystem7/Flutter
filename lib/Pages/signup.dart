import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: Text("SignUp",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 35, left: 20, right: 30),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter UserName',
                    hintText: 'Enter UserName',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter email',
                    hintText: 'Enter valid email id as abc@gmail.com',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Password',
                    hintText: 'Enter secure password',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.greenAccent,
                  color: Colors.black,
                  elevation: 7,
                  child: GestureDetector(
                    onTap: () async {
                      // _register();
                      print('object');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                )
                                .then((value) => {
                                      print(
                                          'Created${"email" + _emailController.text + 'pass' + _passwordController.text}'),
                                      print('value is: ${value}'),
                                      Get.off(HomePage(title: 'Home Page')),
                                    })
                                .onError((error, stackTrace) => {});
                          },
                          child: Text(
                            'SIGNUp',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Go Back',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}