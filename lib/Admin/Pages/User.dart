import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../utils/helper.dart';
import 'Admin.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Page"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            gotoPage(Admin(), context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: StreamBuilder(
        stream: _authService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text("No Product Here"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          // sample product image
                          data['profile_pic'] ??
                              "https://randomuser.me/api/portraits/men/75.jpg",
                        ),
                        radius: 25,
                      ),
                      title: Text(data['name']),
                      subtitle: Text(data['email']),
                      trailing: GestureDetector(
                        onTap: () async {
                          showLoading(context);
                          _authService
                              .deleteUser(data['id'])
                              .then((value) {
                                Navigator.pop(context);
                                showMessage("User Deleted", context);
                                print("THis function is run");
                              })
                              .catchError((error) {
                                Navigator.pop(context);
                                showMessage(error, context);
                              });
                        },
                        child: Icon(Icons.delete, color: Colors.red),
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

// "https://randomuser.me/api/portraits/men/75.jpg",
