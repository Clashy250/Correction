import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'screens/landing/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService()..loadUser(),
      child: MaterialApp(
        title: 'Smart Bin Monitoring',
        theme: ThemeData(
          primaryColor: Colors.teal,
          colorScheme: ColorScheme.light(
            primary: Colors.teal,
            secondary: Colors.orange,
            surface: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
