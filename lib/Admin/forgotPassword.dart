import 'package:baby_shop_hub/Admin/login.dart';
import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF3B5F),
        foregroundColor: Colors.white,
        title: Text("Forget Passord"),
        leading: IconButton(
          onPressed: () {
            gotoPage(Login(), context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                "Forgot\npassword?",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30.h),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email address",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Email is required";
                  } else if (!input.contains('@') || !input.contains('.com')) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              SizedBox(height: 10.h),
              Text(
                "* We will send you a message to set or reset your new password",
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),

              SizedBox(height: 30.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoading(context);
                      _authService
                          .forgetPassword(_emailController.text)
                          .then((value) {
                            Navigator.pop(context);
                            showMessage(
                              "A Password Reset Email has been sent",
                              context,
                            );
                            gotoPage(Login(), context);
                          })
                          .catchError((error) {
                            Navigator.pop(context);
                            showMessage(error, context);
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF3B5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Send Reset Email",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
