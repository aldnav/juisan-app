import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juisan/blocs/stock_for_edit_bloc.dart';
import 'package:juisan/screens/home_page.dart';
import 'package:juisan/screens/loads_page.dart';
import 'package:juisan/screens/orders_page.dart';
import 'package:juisan/screens/profile_page.dart';
import 'package:juisan/screens/safety_page.dart';
import 'package:juisan/screens/stock_page_edit.dart';
import 'package:juisan/utils.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<StockForEditBloc>(
        create: (context) => StockForEditBloc(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Juisan'),
      navigatorKey: Utils.mainNavigatorKey,
      initialRoute: '/',
      // routes: {
      //   Utils.routeHome: (context) => const MyHomePage(title: 'Juisan'),
      //   Utils.routeOrders: (context) => const OrdersPage(),
      //   Utils.routeLoads: (context) => const LoadsFlow(),
      //   Utils.routeSafety: (context) => const SafetyPage(),
      //   Utils.routeProfile: (context) => const ProfilePage(),
      // },
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route? _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    if (settings.name == Utils.routeHome) {
      page = const MyHomePage(title: 'Juisan');
    } else if (settings.name == Utils.routeOrders) {
      page = const OrdersPage();
    } else if (settings.name!.startsWith(Utils.routeLoads)) {
      if (settings.name == Utils.routeLoads) {
        // Handle '/loads'
        page = const LoadsPage();
      } else {
        // TODO: Must consider regex path like Django's re_path
        if (Utils.loadsEditPageRPath.hasMatch(settings.name!)) {
          // Handle '/loads/edit'
          page = const EditStockPage();
        } else {
          // Default to 'loads'
          page = const LoadsPage();
        }
      }
    } else if (settings.name == Utils.routeSafety) {
      page = const SafetyPage();
    } else if (settings.name == Utils.routeProfile) {
      page = const ProfilePage();
    } else {
      throw Exception('Unknown route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}
