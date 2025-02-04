import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'next_page.dart'; // Import the NextPage widget

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0.0,
      end: -20.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NextPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 42, 42, 42),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 42, 42, 42),
        actions: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 3,
            ),
            child: Text(
              'English',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 15,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            print(details);
            if (details.primaryVelocity! < 0) {
              // If the swipe is upwards
              _navigateToNextPage();
            }
          },
          child: Center(
            child: Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/STOSHI-CHAR.png',
                    height: 380,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'STOSHI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _animation.value),
                        child: child,
                      );
                    },
                    child: Icon(
                      FontAwesomeIcons.angleDoubleUp,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
