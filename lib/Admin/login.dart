import 'package:baby_shop_hub/Admin/Pages/Admin.dart';
import 'package:baby_shop_hub/Admin/forgotPassword.dart';
import 'package:baby_shop_hub/Admin/signup.dart';
import 'package:baby_shop_hub/Home.dart';
import 'package:baby_shop_hub/services/auth_service.dart';
import 'package:baby_shop_hub/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "Welcome\nBack!",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40.h),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
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
              SizedBox(height: 15.h),

              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                validator: (input) {
                  if (input!.isEmpty) {
                    return "Password is required";
                  } else if (input.length < 8) {
                    return "Password should be at least 8 characters";
                  }
                  return null;
                },
              ),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPassword(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFFFF3B5F), fontSize: 14.sp),
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoading(context);
                      if (_emailController.text == "admin@firebase.com" &&
                          _passwordController.text == "admin@firebase") {
                        gotoAndRemoveAll(Admin(), context);
                        showMessage("Welcome To Admin Panel", context,desc: "Welcome Admin");
                      } else {
                        await _auth
                            .login(
                              _emailController.text,
                              _passwordController.text,
                            )
                            .then((value) {
                              showMessage(
                                "Logged in",
                                context,
                                desc: "Welcome to Our Website",
                              );
                              gotoAndRemoveAll(HomePage(), context);
                            })
                            .catchError((error) {
                              showMessage(error, context, isError: true);
                            });
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF3B5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // OR Continue
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text("OR Continue with"),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade400)),
                ],
              ),
              SizedBox(height: 20.h),

              // Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton(FontAwesomeIcons.google, Colors.red),
                  SizedBox(width: 20.w),
                  _socialButton(FontAwesomeIcons.apple, Colors.black),
                  SizedBox(width: 20.w),
                  _socialButton(FontAwesomeIcons.facebook, Colors.blue),
                ],
              ),

              SizedBox(height: 30.h),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Create An Account ", style: TextStyle(fontSize: 14.sp)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFFFF3B5F),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(icon, color: color, size: 22.sp),
    );
  }
}
