import 'package:baby_shop_hub/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/CustomBottomNav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductService _productService = ProductService();

  final List<String> sliderImages = [
    "https://i.ibb.co/XrJWdQ43/slider3.png",
    "https://i.ibb.co/kgwkdZbn/slider2.png",
    "https://i.ibb.co/1BFqvyX/slider1.png",
  ];

  int activeIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.5);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu, color: Colors.black),
        centerTitle: true,
        title: Image.network(
          "https://i.ibb.co/qMhT9ZhV/logo.png",
          height: 170.h,
          fit: BoxFit.contain,
        ),
        actions: [
          CircleAvatar(
            backgroundImage: const NetworkImage(
              "https://i.ibb.co/4ZJjF9P/user.png",
            ),
            radius: 18.r,
          ),
          SizedBox(width: 12.w),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search any Product...",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    const Icon(Icons.mic, color: Colors.grey),
                  ],
                ),
              ),

              SizedBox(height: 16.h),

              // Featured Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Featured",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.sort, size: 20.sp),
                      SizedBox(width: 10.w),
                      Icon(Icons.filter_alt_rounded, size: 20.sp),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Slider Section
              CarouselSlider(
                options: CarouselOptions(
                  height: 160.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) {
                    setState(() => activeIndex = index);
                  },
                ),
                items: sliderImages.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 10.h),

              // Dots Indicator
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: sliderImages.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 8.h,
                    dotWidth: 8.w,
                    activeDotColor: Colors.pinkAccent,
                    dotColor: Colors.grey.shade300,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Deal of the Day
              sectionHeader("Deal of the Day", "View all"),
              bannerWidget("Flat and Heels", "Visit Now", Colors.blueAccent),
              SizedBox(height: 16.h),

              // Trending Products
              // Trending Products
              sectionHeader("Trending Products", "View all"),
              SizedBox(
                height: 250.h,
                // child: ListView(
                //   scrollDirection: Axis.horizontal,
                //   children: const [ProductCard(), ProductCard(), ProductCard()],
                // ),
                child: StreamBuilder(
                  stream: _productService.getProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SizedBox(
                          height: 30.w,
                          width: 30.w,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          "No Product Here",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // itemCount: snapshot.data!.length,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return ProductCard(
                            title: data['title'],
                            desc: data['desc'],
                            price: data['price'].toString(),
                            imageUrl: data['imageUrl'],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 16.h),
              // New Arrivals
              sectionHeader("New Arrivals", "View all"),
              bannerWidget("Hot Summer Sale", "Shop Now", Colors.orangeAccent),
              SizedBox(height: 16.h),

              // Sponsored
              sectionHeader("Sponsored", ""),
              sponsoredBannerWidget(
                "https://i.ibb.co/93Y50ZHy/banner2.png",
                "Up to 50% Off",
                "Shop Now",
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),

      // Custom Bottom Nav Bar
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }

  // Section Header Widget
  Widget sectionHeader(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  //  Banner Widget
  Widget bannerWidget(String title, String action, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            action,
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  // Product Item Widget

  // Widget productItem(String name, String price, String image) {
  //   return Container(
  //     width: 200.w,
  //     height: 100.h,
  //     margin: EdgeInsets.only(right: 12.w),
  //     color: Colors.red,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
  //           child: Image.network(
  //             image,
  //             height: 180.h,
  //             width: 200,
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //         Text(
  //           name,
  //           style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  //         ),
  //         SizedBox(height: 6.h),
  //         Text(
  //           price,
  //           style: TextStyle(
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.pinkAccent,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Sponsored Banner Widget
  Widget sponsoredBannerWidget(String imagePath, String title, String action) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4), // dark overlay for white text
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                action,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.title,
    required this.desc,
    required this.price,
    required this.imageUrl,
  });

  String desc, price, title, imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.w, // responsive width
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.network(
                imageUrl,
                height: 140.h,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),

            // Product Info
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  // Price Row
                  Row(
                    children: [
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(width: 6.w),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
