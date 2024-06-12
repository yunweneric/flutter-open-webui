import 'package:flutter/material.dart';
import 'package:flutter_open_animate/pages/components/nar_bar.dart';
import 'package:flutter_open_animate/utils/colors.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animatedAngle;
  PageController bottleController = PageController(initialPage: 0);
  PageController pageController = PageController(initialPage: 0);
  PageController textPageController = PageController(initialPage: 1);
  PageController leavePageController = PageController(initialPage: 0);
  double activeIndex = 0;
  final duration = const Duration(milliseconds: 1500);
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  animate() {
    if (pageController.page == 1) {
      pageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      // bottleController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
    } else {
      pageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      // bottleController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
      textPageController.animateToPage(0, duration: duration, curve: Curves.easeInOutExpo);
      leavePageController.animateToPage(1, duration: duration, curve: Curves.easeInOutExpo);
    }
    setState(() {
      activeIndex = pageController.page ?? 0.0;
    });
  }

  double translate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      body: Stack(
        children: [
          Positioned(
            child: Center(
              child: Image.asset(
                "assets/images/bottle.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          PageView.builder(
            itemCount: 2,
            controller: pageController,
            itemBuilder: (c, i) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                height: Sizing.height(context),
                width: Sizing.width(context),
                color: i == 0 ? AppColors.textBlack : AppColors.bgWhite,
              );
            },
          ),
          PageView.builder(
            itemCount: 2,
            controller: textPageController,
            itemBuilder: (c, i) {
              return Center(
                child: Text(
                  i == 0 ? "DARK" : "LIGHT",
                  style: TextStyle(
                    fontSize: 300,
                    color: i == 0 ? AppColors.textBlack : AppColors.textWhite,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Image.asset(
              "assets/images/bottle.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          NavBar(activeIndex: activeIndex, onToggle: animate),
        ],
      ),
    );
  }
}
