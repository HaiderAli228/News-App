import 'package:flutter/material.dart';
import 'package:news/utils/routes/routes.dart';
import 'package:news/utils/routes/routes_names.dart';
import 'package:news/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue, primarySwatch: Colors.blue),
        initialRoute: RoutesNames.homeScreenView,
        onGenerateRoute: NavigationService.generateRoutes,
      ),
    );
  }
}
// https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=7bf2700f375f4832a56b1320767916c7
