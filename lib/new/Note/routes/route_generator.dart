import 'package:firstproject/new/newMain.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/notes_edit.dart';

class GenerateAllRoutes {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context)=> const NewHomePage());
      case '/home':
        return MaterialPageRoute(builder: (context) => const Home());
      case '/notes_edit':
        return MaterialPageRoute(
            builder: (context) => NotesEdit(settings.arguments));
      default:
        return _unknownRoute();
    }
  }
}

Route<dynamic> _unknownRoute() {
  return MaterialPageRoute(builder: (context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oops!'),
      ),
      body: const Center(
        child: Text('Page not found'),
      ),
    );
  });
}
