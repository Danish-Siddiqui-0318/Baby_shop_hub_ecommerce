import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/helper.dart';
import 'Admin.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Page", style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            gotoPage(Admin(), context);
          },
          child: Icon(Icons.arrow_back_ios, size: 20.sp),
        ),
      ),
      body: StreamBuilder(
        stream: _authService.getAllUsers(),
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
              child: Text("No Product Here", style: TextStyle(fontSize: 16.sp)),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          data['profile_pic'] ??
                              "https://randomuser.me/api/portraits/men/75.jpg",
                        ),
                        radius: 25.r,
                      ),
                      title: Text(
                        data['name'],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      subtitle: Text(
                        data['email'],
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          showLoading(context);
                          _authService
                              .deleteUser(data['id'])
                              .then((value) {
                                Navigator.pop(context);
                                showMessage("User Deleted", context);
                                print("This function is run");
                              })
                              .catchError((error) {
                                Navigator.pop(context);
                                showMessage(error, context);
                              });
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
