
import 'package:flutter/material.dart';
import 'package:instagram/screens/feed_screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  SearchScreen(),
  FeedScreen(),
  AddPostScreen(),
  Text('Notification Screen'),
  Text('Profile Screen'),
];