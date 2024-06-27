import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_open_animate/pages/model/nav_item.dart';
import 'package:flutter_open_animate/utils/asset_helper.dart';
import 'package:flutter_open_animate/utils/sizing.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NavItem> items = [
    NavItem(title: "Messages", icon: AssetHelper.message),
    NavItem(title: "Trending", icon: AssetHelper.trending),
    NavItem(title: "Bookmarks", icon: AssetHelper.bookmark),
    NavItem(title: "Gallery", icon: AssetHelper.gallery),
    NavItem(title: "Settings", icon: AssetHelper.setting),
    NavItem(title: "Notifications", icon: AssetHelper.bell),
    NavItem(title: "People", icon: AssetHelper.people),
  ];
  bool isOpen = false;
  final duration = const Duration(milliseconds: 750);
  ScrollController controller = ScrollController();

  final curve = Curves.easeInOutCubic;

  void toggleAnimation(bool status) {
    double animateFactor = Sizing.width(context) * 0.11;
    setState(() {
      isOpen = status;
      controller.animateTo(isOpen ? animateFactor : 0, duration: duration, curve: curve);
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isOpen ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Stack(
          children: [
            TweenAnimationBuilder(
              duration: duration,
              curve: curve,
              tween: Tween<double>(begin: 0, end: isOpen ? 0.6 : 1.0),
              builder: (context, value, child) {
                return Transform(
                  transform: Matrix4.identity()..scale(value),
                  alignment: const Alignment(0.6, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isOpen ? value * 70 : value * 20),
                    child: Stack(
                      children: [
                        Image.asset(
                          AssetHelper.background,
                          height: Sizing.height(context),
                          width: Sizing.width(context),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: Sizing.height(context) * 0.12,
                          right: Sizing.width(context) * 0.06,
                          child: Transform.scale(scale: 1.2, child: SvgPicture.asset(AssetHelper.profile_svg)),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: Sizing.height(context) * 0.1,
              left: Sizing.width(context) * 0.06,
              child: AnimatedContainer(
                duration: duration,
                curve: curve,
                width: Sizing.width(context) * 0.75,
                height: isOpen ? Sizing.height(context) * 0.8 : 75,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(isOpen ? 30 : 35),
                ),
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                child: Builder(builder: (context) {
                  double scrollFactor = Sizing.width(context) * 0.12;
                  return SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: Sizing.width(context) * 2,
                          height: 45,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                width: scrollFactor,
                                child: InkWell(
                                  onTap: () => toggleAnimation(!isOpen),
                                  child: SvgPicture.asset(AssetHelper.more),
                                ),
                              ),
                              Container(
                                width: Sizing.width(context) * 0.62,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                    filled: true,
                                    fillColor: Theme.of(context).primaryColorLight,
                                    prefixIcon: Transform.scale(scale: 0.5, child: SvgPicture.asset(AssetHelper.search)),
                                    hintText: "Search...",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: scrollFactor,
                                child: InkWell(
                                  onTap: () => toggleAnimation(!isOpen),
                                  child: SvgPicture.asset(AssetHelper.close),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TweenAnimationBuilder(
                          duration: duration,
                          tween: Tween<double>(begin: 0, end: isOpen ? 1.0 : 0.1),
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                child: Transform.scale(
                                  alignment: Alignment.topCenter,
                                  // scaleY: isOpen ? value : (value).clamp(0.8, 1),
                                  scaleY: value,
                                  child: Column(
                                    children: [
                                      ...items.map((item) => navItem(item)).toList(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.asset(
                                                AssetHelper.profile,
                                                width: Sizing.width(context) * 0.15,
                                              ),
                                            ),
                                            Sizing.kWSpacer(10),
                                            const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Hristo Hristov"),
                                                Text("Visual Designer"),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget navItem(NavItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        children: [
          Chip(
            label: SvgPicture.asset(item.icon),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          Sizing.kWSpacer(Sizing.width(context) * 0.02),
          Expanded(child: Text(item.title)),
          if (item.icon == AssetHelper.bell)
            Chip(
              label: Text("8", style: TextStyle(color: Theme.of(context).primaryColorLight)),
              side: BorderSide.none,
              backgroundColor: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            )
        ],
      ),
    );
  }
}
