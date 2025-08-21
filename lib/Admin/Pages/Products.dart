import 'package:baby_shop_hub/Admin/Pages/AddProducts.dart';
import 'package:baby_shop_hub/Admin/Pages/Admin.dart';
import 'package:baby_shop_hub/services/product_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Products extends StatelessWidget {
  Products({super.key});

  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: Text(
          "Products Page",
          style: TextStyle(fontSize: 18.sp),
        ),
        leading: GestureDetector(
          onTap: () {
            gotoPage(Admin(), context);
          },
          child: Icon(Icons.arrow_back_ios, size: 20.sp),
        ),
      ),
      body: StreamBuilder(
        stream: _productService.getProducts(),
        builder: (context, snpashot) {
          if (snpashot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 30.w,
                height: 30.w,
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (snpashot.hasError) {
            return Center(
              child: Text(
                snpashot.error.toString(),
                style: TextStyle(fontSize: 14.sp),
              ),
            );
          } else if (snpashot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Product Here",
                style: TextStyle(fontSize: 16.sp),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snpashot.data!.length,
              itemBuilder: (context, index) {
                var data = snpashot.data![index];
                return Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['imageUrl']),
                        radius: 25.r,
                      ),
                      title: Text(
                        data['title'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category: ${data['category']}",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          Text(
                            "Price:  \$${data['price']}",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              showLoading(context);
                              await _productService
                                  .deleteProduct(data['id'])
                                  .then((value) {
                                Navigator.pop(context);
                                showMessage("Product Deleted", context);
                              }).catchError((error) {
                                Navigator.pop(context);
                                showMessage(error, context, isError: true);
                              });
                            },
                            child: Icon(Icons.delete,
                                color: Colors.red, size: 22.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProducts()),
          );
        },
        child: Icon(Icons.add, size: 30.sp, color: Colors.white),
      ),
    );
  }
}
