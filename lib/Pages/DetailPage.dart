import 'package:flutter/material.dart';

import '../Header/Header.dart';

class DetailsPage extends StatefulWidget {
  final String imageUrl;
  final String details;

  const DetailsPage({
    Key? key,
    required this.imageUrl,
    required this.details,
  }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderPage(
          title: widget.details,
          icon: true,
          onBack: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: Image.network(
              height: double.infinity,
              widget.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'This is new stly',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
