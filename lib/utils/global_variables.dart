import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feed_screens.dart';
import '../screens/add_post_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  SearchScreen(),
  AddPostScreen(),
  Text("notif"),
  Text("peofile"),
];
