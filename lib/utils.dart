import 'package:flutter/cupertino.dart';

class Utils {
  static GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static const routeHome = '/';
  static const routeOrders = '/orders';
  static const routeLoads = '/loads';
  static const loadsPage = '/';
  static const loadsEditPage = '/edit';
  static const routeSafety = '/safety';
  static const routeProfile = '/profile';
}
