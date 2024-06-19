import 'package:firstproject/new/Note/routes/route_generator.dart';
import 'package:firstproject/new/Note/screens/home.dart';
import 'package:firstproject/new/Pages/customButton.dart';
import 'package:firstproject/new/dropdown.dart';
import 'package:firstproject/new/localStorage.dart';
import 'package:firstproject/new/videoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: GenerateAllRoutes.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NewHomePage(),
    );
  }
}

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: const Text(
          'Flutter Demo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: [
              ListTile(
                title: const Text(
                  'Drop down menu',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DropDownMenuScreen(
                        title: 'Drop down menu ',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Appinio Video Player',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VideoScreen(
                        title: 'Appinio Video Player ',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Local Storage',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LocalStorageScreen(
                        title: 'Local Storage',
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Custom Button',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CustomButtonScreen(
                        title: 'Custom Button Demo',
                        text: 'Press Me!',
                        // isSuccess: true,
                        // isLoading: true,
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Add Note',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/home',
                    // MaterialPageRoute(
                    //   builder: (context) =>  const Home(
                    //     // title: 'Important Note ',
                    //   ),
                    // ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

//CustomButtonScreen(
//   title: 'Custom Button Demo',
//   text: 'Press Me!',
//   isLoading: isLoadingState, // Set to true when loading.
//   isSuccess: isSuccessState, // Set to true to show success state.
//   onPressed: () {
//     // Simulate a loading state and then success after some time
//     setState(() {
//       isLoadingState = true; // Set loading state
//     });
//
//     // Simulate async operation
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         isLoadingState = false; // Disable loading indicator
//         isSuccessState = true; // Show success indicator
//       });
//
//       // Reset success indicator after some time
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           isSuccessState = false;
//         });
//       });
//     });
//   },
// )
