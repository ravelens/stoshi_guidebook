import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'home_page.dart'; // Import the HomePage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    // Navigate to HomePage after 5 seconds
    Future.delayed(Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 42, 42),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    widthFactor: _animation.value,
                    child: child,
                  ),
                );
              },
              child: Image.asset(
                'assets/images/STOSHI-CHAR.png',
                height: 207,
              ),
            ),
            SizedBox(height: 20),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontFamily: 'BSST',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Loading ...',
                      speed: Duration(milliseconds: 200)),
                ],
                repeatForever: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
