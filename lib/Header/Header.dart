import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstproject/main.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  const HeaderPage({
    super.key,
    required this.title,
    this.onBack,
    this.icon,
  });

  final String title;
  final VoidCallback? onBack;
  final bool? icon;

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you really want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _logout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    // Add your logout logic here (e.g., clear user session, tokens, etc.)

    FirebaseAuth.instance.signOut().then((value) => {
          print('value is: '),
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) =>  NewHomePage(title: 'Login')),
          )
        });
    // Navigate to NewHomePage
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //       builder: (context) => const NewHomePage(title: 'Login')),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Row(
          children: [
            if (onBack != null)
              IconButton(
                onPressed: onBack,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 23,
                  color: Colors.deepPurpleAccent,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            if (icon != false)
              Padding(
                padding: EdgeInsets.zero,
                child: IconButton(
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(
                    Icons.logout,
                    size: 23,
                    color: Colors.deepPurpleAccent,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                      ),
                      Shadow(blurRadius: BorderSide.strokeAlignCenter)
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
