import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
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
                "Create\nAccount",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40.h),

              // Full Name Field
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Full Name",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15.h),

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.h),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process signup
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF3B5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
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

              // Already have an account link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                      style: TextStyle(fontSize: 14.sp)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
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
