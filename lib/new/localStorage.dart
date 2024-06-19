import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageScreen extends StatefulWidget {
  const LocalStorageScreen({super.key, required this.title});

  final String title;

  @override
  State<LocalStorageScreen> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorageScreen> {
  int _counter = 0;
  static String newText = '';
  late final TextEditingController _textEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCounter();
    newText;
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
      newText = prefs.getString('textValue') ?? '';
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0) + 1;
      prefs.setInt('counter', _counter);
      print('_counter value is $_counter');
    });
  }

  void _setTextAdd() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      newText = _textEdit.text;
      prefs.setString('textValue', newText);
      print('setText is $newText');
    });
  }

  void _resetCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      print('remove before counter value $_counter text is ${_textEdit.text}');
      _counter = 0;
      _textEdit.text = '';
      newText = ''; // Clear newText when resetting
      prefs.remove('counter');
      prefs.remove('textValue');
      print('remove after counter value $_counter text is ${_textEdit.text}');
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    controller: _textEdit,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Add text in store',
                      hintText: 'Store data',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _setTextAdd,
                    child: const Text('Click to Add text'),
                  ),
                  const SizedBox(height: 16),
                  newText.isNotEmpty
                      ? Text(
                          'Store text is: $newText',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : const Text('No data found'),
                  // Display newText here
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Counter:',
            ),
            Text(
              '$_counter',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _resetCounter,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
