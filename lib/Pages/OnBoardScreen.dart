import 'package:baby_shop_hub/Admin/Pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: "Cute Baby Products",
      description:
          "Discover adorable and safe products for your little one. From soft toys to comfy clothing, every item is carefully selected. Make shopping for your baby fun and stress-free.",
      imageUrl: "https://i.ibb.co/7t4cNYBB/Chat-GPT-Image-Aug-21-2025-04-00-25-PM.png",
    ),
    OnboardingData(
      title: "Easy Shopping",
      description:
          "Select your favorite baby items and add them to your cart effortlessly. Enjoy a smooth checkout process with secure payment options. Shopping for your baby has never been easier!",
      imageUrl: "https://i.ibb.co/G4HJW6Z0/Chat-GPT-Image-Aug-21-2025-04-05-37-PM.png",
    ),
    OnboardingData(
      title: "Fast Delivery",
      description:
          "We deliver your baby essentials quickly and safely right to your doorstep. Track your orders with ease and enjoy peace of mind. Get everything your baby needs, right on time.",
      imageUrl: "https://i.ibb.co/GvZXgdBb/Chat-GPT-Image-Aug-21-2025-04-12-12-PM.png",
    ),
  ];

  void _onPageChanged(int page) => setState(() => _currentPage = page);

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to SignUpPage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signup()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top bar: page count and Skip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${_currentPage + 1}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // current num bold
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "/${_pages.length}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal, // normal
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Skip to SignUpPage directly
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PageView with content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Image.network(
                            page.imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        page.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  );
                },
              ),
            ),

            // Bottom bar: centered dots + Next/Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ).copyWith(bottom: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _currentPage == 0
                        ? const SizedBox() // nothing on first page
                        : GestureDetector(
                      onTap: _previousPage,
                      child: const Text(
                        "Previous",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  // Centered dots
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 8,
                      expansionFactor: 3,
                      activeDotColor: Colors.pink,
                      // active = pink
                      dotColor: Colors.black54, // inactive = dark grey
                    ),
                  ),
                  // Next / Get Started button aligned right
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _nextPage,
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? "Get Started"
                            : "Next",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.pink, // pink button text
                          fontWeight: FontWeight.w600,
                        ),
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
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
