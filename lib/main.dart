import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/screens/location.dart';
import 'package:weather_app/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hava Ne Durumdadır',
      home: MyHomePage(title: 'Hava Ne Durumda'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset(
            'assets/splashScreen.json',
            //'https://assets5.lottiefiles.com/packages/lf20_KMqzGr.json',
          ),
          Text(
            'Hava Nasıl',
            style: TextStyle(fontSize: 50, color: Colors.black),
          ),
          Text(
            'Hava Durumunu Öğren',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ],
      ),
      nextScreen: LocationPage(),
      backgroundColor: Colors.white,
      splashIconSize: 500,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
      //pageTransitionType: PageTransitionType.leftToRight,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
