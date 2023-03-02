
import 'package:carousel_slider/carousel_slider.dart';
import 'package:furniturezoid/models/products.dart';
import 'package:furniturezoid/repository/productRepository.dart';
import 'package:furniturezoid/response/productResponse.dart';
import 'package:furniturezoid/utils/productcard.dart';
import 'package:furniturezoid/utils/sideNav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> images = [
  //   "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg",
  //   "https://cdn.pixabay.com/photo/2013/07/21/13/00/rose-165819__340.jpg"
  // ];
  final List productType = [
    [
      'Bedroom',
    ],
    [
      'Living Room',
    ],
    [
      'Kitchen',
    ],
    [
      'Office',
    ],
  ];
  // make String dynamci list of product type

  String? search;

  void CategorySelected(int index) {
    setState(() {
      for (int i = 0; i < productType.length; i++) {
        productType[i][1] = false;
      }
      productType[index][1] = true;
    });
  }

  // int activeimage = 0;
  // Widget buildIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: activeimage,
  //       count: images.length,
  //       effect: const JumpingDotEffect(
  //           dotWidth: 10,
  //           dotHeight: 10,
  //           activeDotColor: Colors.red,
  //           dotColor: Colors.black12),
  //     );

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: SizedBox(
          height: 30,
          child: TextField(
            onChanged: (Value) {
              setState(() {
                search = Value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              prefixIcon:
                  const Icon(Icons.search, color: Colors.black, size: 16),
              hintText: 'Search..',
              hintStyle: const TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.only(top: 5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(102, 64, 45, 1)),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                // borderSide: BorderSide(color: Color.fromARGB(255, 19, 176, 77)),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: Icon(Icons.bedtime_sharp, color: Colors.black),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CarouselSlider(
            items: [
              Image.network('https://hips.hearstapps.com/hmg-prod/images/posters-in-cozy-apartment-interior-royalty-free-image-943910360-1534189931.jpg'),
              Image.network('https://img.staticmb.com/mbcontent//images/uploads/2023/2/luxury-kitchen-interior-design.jpg'),
              Image.network('https://cdn.vondom.com/wp-content/uploads/2022/09/vondom-tulum-outdoor-furniture-eugeni-quitllet.jpg'),
              Image.network('https://i.pinimg.com/564x/9e/60/a5/9e60a54060997debc378ecc0ca5a4df9.jpg'),
            ],
            options: CarouselOptions(
              height: 250.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16/9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),

            // category section
            // SizedBox(
            //   height: 10,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: 
              Text("All Furniture",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 140, 78, 36))),
            ),

            FutureBuilder<ProductResponse?>(
              future: ProductRepository().getproducts(search),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    ProductResponse productResponse = snapshot.data!;
                    List<Product> lstproducts = snapshot.data!.products!;
                    print(snapshot.data!.products!);
                    return GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: lstproducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            productName: lstproducts[index].name.toString(),
                            productPrice: lstproducts[index].price.toString(),
                            productImagePath: lstproducts[index]
                                    .images![0]
                                    .url ??
                                "https://m.media-amazon.com/images/I/31yW0ya1eGL.jpg",
                            onPressed: () {
                              Navigator.pushNamed(context, '/new', arguments: {
                                "images": lstproducts[index].images![0].url,
                                "name": lstproducts[index].name,
                                "price": lstproducts[index].price,
                                "description": lstproducts[index].description,
                                "id": lstproducts[index].id,
                                "rating": lstproducts[index].ratings,
                                "stock": lstproducts[index].stock,
                                "reviews": lstproducts[index].reviews,
                                "time": lstproducts[index].time,
                              });
                            },
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
