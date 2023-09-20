import 'package:flutter/material.dart';
import 'package:freo_assignment/screens/splash_screen.dart';

import '../screens/search_screen.dart';

class Routes {
  static const String home = '/';
  static const String search = '/search';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => SplashScreen(),
      search: (context) => SearchScreen(),
    };
  }
}