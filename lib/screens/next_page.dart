import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stoshi_guildbook/widgets/common_widget.dart';
import 'package:stoshi_guildbook/widgets/header_menu.dart';
import 'package:stoshi_guildbook/widgets/stick_widget.dart';

class NextPage extends StatefulWidget {
  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _killTheBearsSlideAnimation;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  Timer? _debouncer;

  bool _isScrolledPastThreshold = false;
  bool _isShowLabel = false;
  bool _showStoshiText = false;
  bool _showKillTheBearText = false;

  void _navigateBack(BuildContext context) {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    Navigator.of(context).pop();
  }

  void setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );
    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 1.0).animate(_animationController);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(_animationController);
    _killTheBearsSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animation1 =
        Tween<double>(begin: 0, end: 100).animate(_animationController1);
    _animation2 =
        Tween<double>(begin: 0, end: -100).animate(_animationController2);
    _animation3 =
        Tween<double>(begin: 0, end: 100).animate(_animationController3);
  }

  void _optimizedScrollListener() {
    _debouncer?.cancel();
    _debouncer = Timer(const Duration(milliseconds: 50), () {
      if (!mounted) return;
      final pixel = _scrollController.position.pixels;
      if (pixel <= 0) {
        _navigateBack(context);
        return;
      }
      bool passedThreshold = pixel >= 790;
      bool showStoshiText = pixel >= 1000 && !_showStoshiText;
      if (passedThreshold) {
        if (pixel >= 1900 && !_animationController1.isAnimating) {
          _animationController1.forward();
          Future.delayed(Duration(seconds: 2), () {
            if (!mounted) return;
            _animationController2.forward();
          });
          Future.delayed(Duration(seconds: 4), () {
            if (!mounted) return;
            _animationController3.forward();
          });
        }
        if (pixel >= 1300) {
          if (_showStoshiText) {
            setState(() {
              _slideAnimation = Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, -1))
                  .animate(_animationController);
              _showKillTheBearText = true;
            });
            _animationController.forward();
          }
        }
        if (pixel >= 1000 && !_showStoshiText) {
          setState(() {
            _showStoshiText = true;
          });
          _animationController.forward();
        }
        // if (showStoshiText) {
        //   setState(() {
        //     _showStoshiText = true;
        //   });
        //   _animationController.forward();
        // } else if (pixel >= 1900) {
        //   if (!_animationController1.isAnimating) {
        //     _animationController1.forward();
        //     Future.delayed(const Duration(seconds: 2), () {
        //       _animationController2.forward();
        //     });
        //     Future.delayed(const Duration(seconds: 4), () {
        //       _animationController3.forward();
        //     });
        //   }
        // } else if (pixel >= 1300) {
        //   if (_showStoshiText) {
        //     setState(() {
        //       _slideAnimation = Tween<Offset>(
        //               begin: const Offset(0, -1), end: const Offset(0, -1))
        //           .animate(_animationController);
        //       _showKillTheBearText = true;
        //     });
        //     _animationController.forward();
        //   }
        // }
        // Further animation handling
      } else {
        // Handle reverse animations or stopping animations
        if (_showStoshiText && pixel <= 1000) {
          reverseAnimations();
          _animationController.reverse().then((value) {
            if (!mounted) return;
            setState(() {
              _showStoshiText = false;
            });
          });
        }
      }
    });
    // if (pixel >= 1000) {
    //   if (!_showStoshiText) {
    //     setState(() {
    //       _showStoshiText = true;
    //     });
    //     _animationController.forward();
    //   } else if (pixel >= 1900) {
    //     if (!_animationController1.isAnimating) {
    //       _animationController1.forward();
    //       Future.delayed(const Duration(seconds: 2), () {
    //         _animationController2.forward();
    //       });
    //       Future.delayed(const Duration(seconds: 4), () {
    //         _animationController3.forward();
    //       });
    //     }
    //   } else if (pixel >= 1300) {
    //     if (_showStoshiText) {
    //       setState(() {
    //         _slideAnimation = Tween<Offset>(
    //                 begin: const Offset(0, -1), end: const Offset(0, -1))
    //             .animate(_animationController);
    //         _showKillTheBearText = true;
    //       });
    //       _animationController.forward();
    //     }
    //   }
    // } else if (pixel < 960 && _showStoshiText) {
    //   _animationController.reverse().then((value) {
    //     setState(() {
    //       _showStoshiText = false;
    //       _showKillTheBearText = false;
    //     });
    //     _animationController3.reverse();
    //     _animationController2.reverse();
    //     _animationController1.reverse();
    //   });
    // }
    // if (!_isScrolledPastThreshold) {
    //   setState(() {
    //     _isScrolledPastThreshold = true;
    //   });
    // } else if (pixel >= 1160) {
    //   setState(() {
    //     _isShowLabel = true;
    //   });
    // } else if (pixel <= 1160) {
    //   setState(() {
    //     _isShowLabel = false;
    //   });
    // }
  }

  void reverseAnimations() {
    _animationController1.reverse();
    _animationController2.reverse();
    _animationController3.reverse();
  }

  @override
  void initState() {
    super.initState();
    setupAnimations();
    _scrollController.addListener(_optimizedScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        27,
        40,
        34,
      ),
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollStartNotification ||
                  scrollInfo is ScrollUpdateNotification ||
                  scrollInfo is ScrollEndNotification) {
                if (scrollInfo.metrics.pixels <= 0 &&
                    scrollInfo is ScrollUpdateNotification &&
                    scrollInfo.dragDetails?.primaryDelta != null &&
                    scrollInfo.dragDetails!.primaryDelta! > 20) {
                  _navigateBack(context);
                  return true;
                }
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          color: const Color.fromARGB(255, 42, 42, 42),
                        ),
                        Positioned(
                          top: 250,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            color: const Color.fromARGB(255, 32, 32, 32),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              'assets/images/STOSHI-CHAR.png',
                              height: 250,
                            ),
                          ),
                        ),
                      ],
                    ),
                    FadeTransition(
                      opacity: const AlwaysStoppedAnimation(1.0),
                      child: Container(
                        color: const Color.fromARGB(255, 32, 32, 32),
                        child: Column(
                          children: [
                            const Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    'Hype Projects',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'STOSHI',
                              style: TextStyle(
                                color: Color.fromARGB(255, 27, 203, 77),
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              '2024',
                              style: TextStyle(
                                color: Color.fromARGB(255, 55, 118, 73),
                                fontSize: 20,
                              ),
                            ),
                            const Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    'ABOUT STOSHI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset(
                              'assets/images/door.png',
                              width: 375,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Are you an NFT enthusiast ?",
                          ),
                          const Text(
                            "Or just diving into the world of digital art and blockchain ?",
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Congratulations !",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "You've found yourself in a vibrant community of like-minded individuals who share a passion for innovation and creativity.",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/STOSHI-ICON-FINAL.png',
                                  height: 183,
                                ),
                                if (_showStoshiText)
                                  SlideTransition(
                                    position: _slideAnimation,
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: const Text(
                                        'STOSHI',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_showKillTheBearText)
                                  SlideTransition(
                                    position: _killTheBearsSlideAnimation,
                                    child: FadeTransition(
                                      opacity: _opacityAnimation,
                                      child: const Text(
                                        'KILL THE BEARS',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Let\'s explore, create, and innovate together. ',
                          ),
                          const Text(
                            'Welcome aboard, and let\'s make history in the world of NFTs!',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 40,
                                  ),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(children: [
                                  Image.asset(
                                    'assets/images/question.png',
                                    width: 80,
                                  ),
                                  const Text(
                                    'WTF IS STOSHI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ]),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 40,
                                  ),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 52,
                                color: const Color(0xFF40BA37),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                "How The F*ck We Doing STOSHI’s?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "We are ALL about our community, and for our community.",
                          ),
                          const Text(
                            "And here’s what you might’ve missed :",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 170, 156, 28),
                                width: 3,
                              ),
                              color: const Color.fromARGB(
                                255,
                                26,
                                37,
                                35,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 5,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    componentText("SUPPLY"),
                                    componentText(":"),
                                    componentText("150"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    componentText("CHAIN"),
                                    componentText(":"),
                                    componentText("BITCOIN"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    componentText("PRICE"),
                                    componentText(":"),
                                    componentText("FREE"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    componentText("MINT"),
                                    componentText(":"),
                                    componentText("TBA"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Do you feel that ?',
                          ),
                          const Text(
                            'That feeling is called FO-f*cking-MO.',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 52,
                                color: const Color(0xFF40BA37),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                "What is your key or goals on STOSHII ?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Final GOALs on STOSHI is to be : ",
                          ),
                          Stack(
                            children: <Widget>[
                              // Stroked text as the base layer.
                              Text(
                                "CHOSEN ONE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 1
                                    ..color =
                                        const Color.fromARGB(167, 27, 203, 77),
                                ),
                              ),
                              // Solid text as the top layer.
                              const Text(
                                "CHOSEN ONE",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 52, 151, 218),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 40,
                                  ),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(children: [
                                  Image.asset(
                                    'assets/images/RoadToSTOSHI.png',
                                    width: 80,
                                  ),
                                  const Text(
                                    'ROAD TO STOSHI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )
                                ]),
                              ),
                              const Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 40,
                                  ),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildAnimatedSticks(
                            _animation1,
                            _animation2,
                            _animation3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildHeaderMenu(
              context, _isScrolledPastThreshold, _isShowLabel, "ABOUT STOSHI"),
        ],
      ),
    );
  }
}
