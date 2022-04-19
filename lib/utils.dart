import 'package:flutter/cupertino.dart';

class Utils {
  static GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  static const routeHome = '/';
  static const routeOrders = '/orders';
  static const routeLoads = '/loads';
  static const loadsEditPage = routeLoads + '/edit';
  static final loadsEditPageRPath = RegExp(r'^\/loads\/edit');
  static const routeSafety = '/safety';
  static const routeProfile = '/profile';
}
