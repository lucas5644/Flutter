import 'package:flutter/material.dart';
import 'package:flutter_social/screens/comment/comment_screen.dart';
import 'package:flutter_social/screens/edit_profile/edit_profile_screen.dart';
import 'package:flutter_social/screens/feed/feed_screen.dart';
import 'package:flutter_social/screens/home/home_screen.dart';
import 'package:flutter_social/screens/landing/landing_screen.dart';
import 'package:flutter_social/screens/log_in_screen/log_in_screen.dart';
import 'package:flutter_social/screens/notification/notification_screen.dart';
import 'package:flutter_social/screens/post_detail/post_detail_screen.dart';
import 'package:flutter_social/screens/profile/profile_screen.dart';
import 'package:flutter_social/screens/profile_details/profile_details_screen.dart';
import 'package:flutter_social/screens/write/write_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LogInScreen.routeName: (context) => LogInScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  FeedScreen.routeName: (context) => FeedScreen(),
  NotificationScreen.routeName: (context) => NotificationScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  LandingScreen.routeName: (context) => LandingScreen(),
  WriteScreen.routeName: (context) => WriteScreen(),
  EditProfilScreen.routeName: (context) => EditProfilScreen(),
  ProfilDetailsScreen.routeName: (context) => ProfilDetailsScreen(),
  PostDetailScreen.routeName: (context) => PostDetailScreen(),
  CommentScreen.routeName: (context) => CommentScreen(),
};
