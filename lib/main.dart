import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstproject/Header/Header.dart';
import 'package:firstproject/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './Pages/signup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('App is running');
    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const NewHomePage(
        title: 'Login Page',
      ),
      // return home: FutureBuilder(future:  Firebase.initializeApp(),),
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
    );
  }
}

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key, required this.title});

  final String title;

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderPage(
          title: widget.title,
          icon: false,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
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
          Container(
            alignment: const Alignment(1, 1),
            padding: const EdgeInsets.only(
              top: 15,
              right: 16,
            ),
            child: const InkWell(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: _OutlinedButton(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('Register');
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final email = emailController.text;
        final password = passwordController.text;

        if (email.isEmpty) {
          Get.snackbar("Error", "Please enter your email",
              snackPosition: SnackPosition.TOP);
        } else if (password.isEmpty) {
          Get.snackbar("Error", "Please enter your password",
              snackPosition: SnackPosition.TOP);
        } else if (!_isValidEmail(email)) {
          Get.snackbar("Error", "Please enter a valid email",
              snackPosition: SnackPosition.TOP);
        } else if (!_isValidPassword(password)) {
          Get.snackbar("Error", "Please enter a valid password",
              snackPosition: SnackPosition.TOP);
        } else {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) => {
                    print('Success to login ${value} =='),
                    Get.off(const HomePage(title: 'Home Page '),
                        arguments: [email, password]),
                  })
              .onError((error, stackTrace) => {print('Error ${error}')});
        }
      },
      child: const Column(
        children: [
          Text('Login'),
        ],
      ),
    );
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        // r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        '@');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 4;
  }
}
