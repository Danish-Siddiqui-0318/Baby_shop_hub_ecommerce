import 'package:baby_shop_hub/Admin/Pages/AddProducts.dart';
import 'package:baby_shop_hub/Admin/Pages/Admin.dart';
import 'package:baby_shop_hub/services/product_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  Products({super.key});

  ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        title: const Text("Products Page"),
        leading: GestureDetector(
          onTap: () {
            gotoPage(Admin(), context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: StreamBuilder(
        stream: _productService.getProducts(),
        builder: (context, snpashot) {
          if (snpashot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snpashot.hasError) {
            return Center(child: Text(snpashot.error.toString()));
          } else if (snpashot.data!.isEmpty) {
            return Center(child: Text("No Product Here"));
          } else {
            return ListView.builder(
              itemCount: snpashot.data!.length,
              itemBuilder: (context, index) {
                var data = snpashot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['imageUrl']),
                        radius: 25,
                      ),
                      title: Text(data['title']),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category: ${data['category']}"),
                          Text("Price:  \$${data['price']}"),
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
                                  })
                                  .catchError((error) {
                                    Navigator.pop(context);
                                    showMessage(error, context, isError: true);
                                  });
                            },
                            child: Icon(Icons.delete, color: Colors.red),
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
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
