import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';

import 'data/models/models.dart';
import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        dividerColor: Colors.transparent,
        textTheme: textTheme,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        DetailScreen.routeName: (context) {
          final arguments =
              ModalRoute.of(context)?.settings.arguments as ScreenArguments;
          return DetailScreen(
            id: arguments.id,
            pictureId: arguments.pictureId,
          );
        },
        SearchScreen.routeName: (context) => const SearchScreen(),
      },
    );
  }
}
