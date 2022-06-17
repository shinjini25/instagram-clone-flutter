
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/methods/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
//     import 'package:instagram_clone/models/user.dart' as model;
// import 'package:provider/provider.dart';
// import '../providers/user_provider.dart';

class  MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  final PageController _pageController = PageController();

  int _page= 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  //change page according to icon pressed
  void navigationTapped(int page) {
  _pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
   //  @override
   // void initState(){
   //  super.initState();
   //  }

    // model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged ,
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: _page == 0? primaryColor: secondaryColor), label: "", backgroundColor: primaryColor, ),
          BottomNavigationBarItem(icon: Icon(Icons.search, color: _page == 1? primaryColor: secondaryColor), label: "", backgroundColor: primaryColor, ),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, color: _page == 2? primaryColor: secondaryColor), label: "", backgroundColor: primaryColor, ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite, color: _page == 3? primaryColor: secondaryColor), label: "", backgroundColor: primaryColor, ),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_alt_1_rounded, color: _page == 4? primaryColor: secondaryColor), label:'', ),

        ],
        onTap: navigationTapped,
      ),
    );
  }

}
