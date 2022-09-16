import 'package:contact_diary_app/screens/add_contact_page.dart';
import 'package:contact_diary_app/screens/dashboard.dart';
import 'package:contact_diary_app/screens/detail_page.dart';
import 'package:contact_diary_app/screens/splash_screen.dart';
import 'package:contact_diary_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      const HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: (AppTheme.isDark == false) ? ThemeMode.light : ThemeMode.dark,
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const Dashboard(),
        'add_contact_page': (context) => const AddContactPage(),
        'detail_page': (context) => const DetailPage(),
        'splash_screen': (context) => const SplashScreen(),
      },
    );
  }
}
