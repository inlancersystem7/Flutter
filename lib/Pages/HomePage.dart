import 'package:firstproject/Pages/ShopPage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

import '../Header/Header.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    "https://5.imimg.com/data5/SELLER/Default/2022/9/VK/FQ/EG/17769549/ap0015.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2022/9/RL/ZT/GR/17769549/bkt001-5347-1000x1000.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2022/9/TE/IH/KW/17769549/bkt00125-1000x1000.jpeg",
    "https://5.imimg.com/data5/SELLER/Default/2022/9/OZ/MM/UW/17769549/bkt0041--1000x1000.jpg",
  ];
  final List<String> urlImage = [
    "https://media.istockphoto.com/id/1460651564/photo/indian-men-latest-fashion-shirts-in-display-retail-shop-in-market-traditional-wear-for-men.jpg?s=1024x1024&w=is&k=20&c=cmHEqmxsr6gTTXxXo-dlQjcujs_iNf6w5zq2MndLuEU=",
    "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://media.istockphoto.com/id/1136561987/photo/different-colored-shirts-hanging-on-a-rack.jpg?s=612x612&w=0&k=20&c=CpXTlEM5atn2GxJ_uB0L49tqPrAVjJyBHXmfumtM988=",
    "https://images.unsplash.com/photo-1529720317453-c8da503f2051?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://media.istockphoto.com/id/1680261590/photo/rack-with-stylish-womens-clothes-concept-for-shopping-store-beauty-fashion.jpg?s=612x612&w=0&k=20&c=hRVrd70phPBDEK3ZGvRLjNLG_v99Di_FnpCKd7UdfG0=",
    "https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];

  final List<Map<String, String>> imageList = [
    {
      'title': 'Name of Shop 1',
      'url':
          "https://media.istockphoto.com/id/1460651564/photo/indian-men-latest-fashion-shirts-in-display-retail-shop-in-market-traditional-wear-for-men.jpg?s=1024x1024&w=is&k=20&c=cmHEqmxsr6gTTXxXo-dlQjcujs_iNf6w5zq2MndLuEU=",
    },
    {
      'title': 'Name of Shop 2',
      'url':
          "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      'title': 'Name of Shop 3',
      'url':
          "https://media.istockphoto.com/id/1136561987/photo/different-colored-shirts-hanging-on-a-rack.jpg?s=612x612&w=0&k=20&c=CpXTlEM5atn2GxJ_uB0L49tqPrAVjJyBHXmfumtM988=",
    },
    {
      'title': 'Name of Shop 4',
      'url':
          "https://images.unsplash.com/photo-1529720317453-c8da503f2051?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      'title': 'Name of Shop 5',
      'url':
          "https://media.istockphoto.com/id/1680261590/photo/rack-with-stylish-womens-clothes-concept-for-shopping-store-beauty-fashion.jpg?s=612x612&w=0&k=20&c=hRVrd70phPBDEK3ZGvRLjNLG_v99Di_FnpCKd7UdfG0=",
    },
    {
      'title': 'Name of Shop 6',
      'url':
          "https://images.unsplash.com/photo-1551488831-00ddcb6c6bd3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      'title': 'Name of Shop 7',
      'url':
          "https://images.unsplash.com/photo-1445205170230-053b83016050?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      'title': 'Name of Shop 8',
      'url':
          "https://media.istockphoto.com/id/1460651564/photo/indian-men-latest-fashion-shirts-in-display-retail-shop-in-market-traditional-wear-for-men.jpg?s=1024x1024&w=is&k=20&c=cmHEqmxsr6gTTXxXo-dlQjcujs_iNf6w5zq2MndLuEU=",
    },
    {
      'title': 'Name of Shop 9',
      'url':
          "https://images.unsplash.com/photo-1596755094514-f87e34085b2c?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var amid = Get.arguments;

    void navigateToImageDetails(String imageUrl, String details) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsPage(
            imageUrl: imageUrl,
            details: details,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: HeaderPage(
          title: widget.title,
          icon: true,
        ),
        automaticallyImplyLeading: false,
      ),
      // backgroundColor: const Color.fromARGB(38, 38, 38, 97),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8, top: 5),
                        child: Text(
                          'shop to new style',
                          style: TextStyle(
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  color: Colors.black26,
                  // Set your desired background color here
                  child: SizedBox(
                    // height: 500,
                    // width: screenWidth * 0.9 ,
                    // width: double.infinity,
                    child: CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) => AspectRatio(
                        aspectRatio: 16 / 2,
                        child: Image.network(
                          urlImages[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: const Duration(seconds: 0),
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                        height: 440,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Try to new style',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    ),
                    Spacer(),
                    _ElevatedButtons(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: imageList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        navigateToImageDetails(
                          imageList[index]['url']!,
                          imageList[index]['title']!,
                        );
                      },
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            imageList[index]['url']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Image.network(
      urlImage,
      fit: BoxFit.cover,
    );

class _Buttons extends StatelessWidget {
  const _Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.lightBlueAccent),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      onPressed: () {
        debugPrint('Received click values');
        Get.to(const ShopPage(title: 'Shop Page'));
      },
      child: const Text(
        'Go to shop page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ElevatedButtons extends StatefulWidget {
  const _ElevatedButtons({Key? key});

  @override
  State<_ElevatedButtons> createState() => _ElevatedButtonStates();
}

class _ElevatedButtonStates extends State<_ElevatedButtons> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.to(const ShopPage(title: 'Shop Page'));
      },
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('View more'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
