import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Header/Header.dart';

class UserPage extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String productName;
  final int productPrice;

  const UserPage({
    required this.title,
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int itemCount = 1; // Start with 1 item
  // Function to increment item count
  void incrementCount() {
    setState(() {
      itemCount++;
    });
  }

  // Function to decrement item count
  void decrementCount() {
    setState(() {
      if (itemCount > 1) {
        itemCount--;
      }
    });
  }

  // Calculate total price based on item count
  int getTotalPrice() {
    return itemCount * widget.productPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderPage(
          icon: false,
          title: widget.productName,
          onBack: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        // Wrap your content with SingleChildScrollView
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(widget.imageUrl),
              const SizedBox(height: 20),
              Text(widget.productName),
              const SizedBox(height: 20),
              Text('₹${widget.productPrice * itemCount}'),
              Text(
                'Items $itemCount',
                style: TextStyle(color: Colors.deepPurple),
              ),
              Row(
                children: [
                  Card(
                    child: CountButton(
                      itemCount: itemCount,
                      onIncrement: incrementCount,
                      onDecrement: decrementCount,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              // Add some extra space at the bottom for better scrolling
            ],
          ),
        ),
      ),
    );
  }
}

class CountButton extends StatefulWidget {
  final int itemCount;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CountButton({
    required this.itemCount,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  _CountButtonState createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: widget.onIncrement,
          ),
          Text(
            widget.itemCount.toString(),
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: widget.onDecrement,
          ),
        ],
      ),
    );
  }
}
