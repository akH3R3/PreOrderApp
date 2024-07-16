import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pre_order_app/screens/auth_screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 1);
              });
            },
            children: [
              Container(
                color: Colors.pinkAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://lottie.host/c2e9291f-920f-409d-89a5-c84042b5099f/Kx7timZh6B.json',
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Welcome to ApnaBazar!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Discover the products you want in your daily life.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Here you get laptops, t-shirts, jackets, phones, sneakers and many more. ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 229, 216, 216),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.network(
                      'https://lottie.host/b57444f9-4f3a-49e3-b5ca-316a53ab6cd1/cxmCRVrPqU.json',
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Get Started!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        'Join our community and start your journey towards a bright future with our sustainable products.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text("Skip"),
                ),
                SmoothPageIndicator(controller: _controller, count: 2),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        child: const Text("Done"),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text("Next"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}