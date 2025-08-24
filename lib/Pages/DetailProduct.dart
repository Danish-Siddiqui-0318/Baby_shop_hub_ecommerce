import 'package:baby_shop_hub/Pages/HomeScreen.dart';
import 'package:baby_shop_hub/widgets/CustomBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  bool _detailsExpanded = false;

  final String productImage =
      'https://i.ibb.co/XrJWdQ43/slider3.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
            (route) => false,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Single Product Image
              Container(
                height: 240.h,
                margin: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  image: DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Title
              Text(
                'NIke Sneakers',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10.h),

              // Price Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '\$1,500',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '\$2,999',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(6.r)),
                    child: Text(
                      '50% Off',
                      style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w600, fontSize: 12.sp),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              // Product Details
              Text(
                'Product Details',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8.h),
              Text(
                'Perhaps the most iconic sneaker of all-time, this original “Chicago” colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the ...',
                maxLines: _detailsExpanded ? null : 3,
                overflow: _detailsExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.sp, height: 1.4),
              ),
              SizedBox(height: 6.h),
              GestureDetector(
                onTap: () => setState(() => _detailsExpanded = !_detailsExpanded),
                child: Text(
                  _detailsExpanded ? 'Show less' : 'Read more',
                  style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w600, fontSize: 13.sp),
                ),
              ),

              SizedBox(height: 16.h),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_cart_outlined, color: Colors.blue, size: 20.sp),
                      label: Text('Go to cart', style: TextStyle(color: Colors.blue, fontSize: 14.sp)),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: BorderSide(color: Colors.blue.shade100),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                      ),
                      child: Text('Buy Now', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              // Delivery info tag
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.delivery_dining, color: Colors.pink, size: 22.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black87, fontSize: 13.sp),
                          children: [
                            const TextSpan(text: 'Delivery in '),
                            TextSpan(
                              text: '1 within Hour',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('View Policy', style: TextStyle(color: Colors.pink, fontSize: 13.sp)),
                    )
                  ],
                ),
              ),

              SizedBox(height: 18.h),

              // Similar Items section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Similar To', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  Text('282+ Items', style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
                ],
              ),
              SizedBox(height: 12.h),

              SizedBox(
                height: 160.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (_, __) => SizedBox(width: 12.w),
                  itemBuilder: (context, index) {
                    return _SimilarItemCard(
                      title: 'Nike Sneakers',
                      price: '\$1,900',
                      rating: 4.5,
                      imageUrl: productImage,
                    );
                  },
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}

class _SimilarItemCard extends StatelessWidget {
  final String title;
  final String price;
  final double rating;
  final String imageUrl;

  const _SimilarItemCard({
    required this.title,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Container(
            height: 88.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 6.h),
                Text(price, style: TextStyle(fontSize: 13.sp, color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
