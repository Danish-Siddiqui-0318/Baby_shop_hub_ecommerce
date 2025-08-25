import 'package:baby_shop_hub/Pages/DetailProduct.dart';
import 'package:baby_shop_hub/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/CustomBottomNav.dart';

class ProductsUser extends StatefulWidget {
  ProductsUser({super.key});

  @override
  State<ProductsUser> createState() => _ProductsUserState();
}

class _ProductsUserState extends State<ProductsUser> {
  ProductService _productService = ProductService();
  int? productsQty;

  // @override
  // void initState() {
  //   super.initState();
  //   _productService.getProductsqty().listen((event)=>(productsQty=event));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // input field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        // fillColor: Colors.white,
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

            // item count
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("${productsQty.toString()} Items"),
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  // Shadow color
                                  spreadRadius: 2,
                                  // How wide the shadow spreads
                                  blurRadius: 4,
                                  // Softness of the shadow
                                  offset: Offset(
                                    2,
                                    4,
                                  ), // Position of the shadow (x, y)
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              spacing: 2,
                              children: [
                                Text("Sort"),
                                SizedBox(width: 10.w),
                                Icon(Icons.sort_outlined),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  // Shadow color
                                  spreadRadius: 2,
                                  // How wide the shadow spreads
                                  blurRadius: 6,
                                  // Softness of the shadow
                                  offset: Offset(
                                    2,
                                    4,
                                  ), // Position of the shadow (x, y)
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Row(
                              spacing: 2,
                              children: [
                                Text("Filter"),
                                SizedBox(width: 10.w),
                                Icon(Icons.filter_alt_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // fetching products
            Expanded(
              child: StreamBuilder(
                stream: _productService.getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        width: 30.w,
                        height: 30.w,
                        child: const CircularProgressIndicator(),
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
                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailProduct(product: data),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    data['imageUrl'],
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              height: 150,
                                              color: Colors.grey[200],
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error_outline,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // Text(
                                      //   data['desc'],
                                      //   style: TextStyle(fontSize: 12, color: Colors.grey),
                                      //   maxLines: 3,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      SizedBox(height: 8),
                                      Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        "Category : " + data['category'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                            255,
                                            35,
                                            34,
                                            34,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '\$${(data["price"] as double).toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                            255,
                                            35,
                                            34,
                                            34,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}
