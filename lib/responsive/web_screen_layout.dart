import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/colors.dart';
import '../utils/global_variables.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  final PageController _pageController = PageController();

  int _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //change page according to icon pressed
  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mobileBackgroundColor,
          title: SvgPicture.asset(
            'assets/ig_logo.svg',
            color: primaryColor,
            height: 30,
          ),
          actions: [
            IconButton(
              onPressed: () => navigationTapped(0),
              icon: Icon(Icons.home,
                  color: _page == 0 ? primaryColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(1),
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(2),
              icon: Icon(Icons.add_a_photo,
                  color: _page == 2 ? primaryColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(3),
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
            ),
            IconButton(
              onPressed: () => navigationTapped(4),
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
            ),
          ],
        ),
        body: PageView(
          children: homeScreenItems,
          controller: _pageController,
          onPageChanged: onPageChanged,
        ));
  }
}
