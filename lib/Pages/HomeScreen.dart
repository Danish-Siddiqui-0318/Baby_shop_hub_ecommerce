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
  final List<String> sliderImages = [
    "assets/slider1.png",
    "assets/slider2.png",
    "assets/slider3.png",
  ];

  int activeIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.55);
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
        title: Image.asset(
          "assets/logo.png",
          height: 170.h,
          fit: BoxFit.contain,
        ),
        actions: [
          CircleAvatar(
            backgroundImage: const AssetImage("assets/user.png"),
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
                  )
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
                    child: Image.asset(
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
              sectionHeader("Trending Products", "View all"),
              SizedBox(
                height: 220.h,
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      children: [
                        productItem("Women Printed Kurta", "₹1500", "pro1.png"),
                        productItem("HRX Shoes", "₹2499", "pro2.png"),
                        productItem("White Sneakers", "₹650", "pro3.png"),
                      ],
                    ),

                    Positioned(
                      left: 0,
                      top: 80.h,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 20.sp),
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),

                    Positioned(
                      right: 0,
                      top: 80.h,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 20.sp),
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // New Arrivals
              sectionHeader("New Arrivals", "View all"),
              bannerWidget("Hot Summer Sale", "Shop Now", Colors.orangeAccent),
              SizedBox(height: 16.h),

              // Sponsored
                 sectionHeader("Sponsored", ""),
                  sponsoredBannerWidget("banner2.png", "Up to 50% Off", "Shop Now"),
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
        Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        if (actionText.isNotEmpty)
          Text(
            actionText,
            style: TextStyle(color: Colors.pinkAccent, fontSize: 14.sp, fontWeight: FontWeight.w500),
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
          Text(title, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold)),
          Text(action, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
        ],
      ),
    );
  }

  // Product Item Widget
  Widget productItem(String name, String price, String image) {
    return Container(
      margin: EdgeInsets.only(right: 12.w, top: 10.h,bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.asset(
              image,
              height: 120.h,
              width: 140.w,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                  SizedBox(height: 4.h),
                  Text(price, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Sponsored Banner Widget
Widget sponsoredBannerWidget(String imagePath, String title, String action) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.h),
    height: 140.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      image: DecorationImage(
        image: AssetImage(imagePath),
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
