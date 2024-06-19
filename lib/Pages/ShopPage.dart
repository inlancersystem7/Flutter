import 'package:firstproject/Pages/Product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Header/Header.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key, required this.title});

  final String title;

  @override
  State<ShopPage> createState() => _ShopPage();
}

class _ShopPage extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderPage(
          title: widget.title,
          onBack: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
        automaticallyImplyLeading: false,
      ),
      // backgroundColor: Colors.black12,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.5,
            children: List.generate(
              data.length,
              (index) => Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  child: Card(

                    child: Column(
                      children: [
                        Flexible(
                          // flex: 1,
                          child: Column(
                            children: [
                              Image.network(data[index]),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text('Product ${index + 1}'),
                              ),
                              Text('₹${100 * (index + 1)}'),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  child: const Text('Add to Cart'),
                                  onPressed: () {
                                    Get.to(UserPage(
                                      title: 'Detail page',
                                      imageUrl: data[index],
                                      // Pass image URL
                                      productName: 'Product ${index + 1}',
                                      // Pass product name
                                      productPrice: 100 *
                                          (index + 1), // Pass product price
                                    ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({super.key});

  @override
  Widget build(BuildContext context) {
    var values = 1;
    return OutlinedButton(
      onPressed: () {
        debugPrint('Received click $values');
        // Get.to(HomePage(title: 'Home Page'));
      },
      child: const Text('Click Me'),
    );
  }
}

const data = [
  "https://5.imimg.com/data5/SELLER/Default/2022/9/VK/FQ/EG/17769549/ap0015.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/RL/ZT/GR/17769549/bkt001-5347-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/TE/IH/KW/17769549/bkt00125-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/OZ/MM/UW/17769549/bkt0041--1000x1000.jpg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/VK/FQ/EG/17769549/ap0015.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/RL/ZT/GR/17769549/bkt001-5347-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/TE/IH/KW/17769549/bkt00125-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/OZ/MM/UW/17769549/bkt0041--1000x1000.jpg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/VK/FQ/EG/17769549/ap0015.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/RL/ZT/GR/17769549/bkt001-5347-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/TE/IH/KW/17769549/bkt00125-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/OZ/MM/UW/17769549/bkt0041--1000x1000.jpg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/VK/FQ/EG/17769549/ap0015.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/RL/ZT/GR/17769549/bkt001-5347-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/TE/IH/KW/17769549/bkt00125-1000x1000.jpeg",
  "https://5.imimg.com/data5/SELLER/Default/2022/9/OZ/MM/UW/17769549/bkt0041--1000x1000.jpg",
];
