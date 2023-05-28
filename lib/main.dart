import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:third_app/Screen/splash_screen.dart';
import 'Provider/bottom_nav_provider.dart';
import 'Provider/getStatusProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => GetStatusProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 149, 159, 216),
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 71, 96, 236)),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
