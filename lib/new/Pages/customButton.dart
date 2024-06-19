import 'package:flutter/material.dart';

class CustomButtonScreen extends StatefulWidget {
  final String title;
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isSuccess;

  const CustomButtonScreen({
    super.key,
    required this.title,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isSuccess = false,
  });

  @override
  State<CustomButtonScreen> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (!widget.isLoading && !widget.isSuccess) {
              widget.onPressed();
            }
          },
          child: buildButtonChild(),
        ),
      ),
    );
  }

  Widget buildButtonChild() {
    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          ),
          const SizedBox(width: 10),
          Text(widget.text),
        ],
      );
    } else if (widget.isSuccess) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.text),
          const Icon(Icons.tiktok, color: Colors.black),
        ],
      );
    } else {
      return Text(widget.text);
    }
  }
}
