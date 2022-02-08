import 'package:flutter/material.dart';
import 'package:security_check_in/view/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  final Tween<double> animation = Tween(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    animation.animate(animationController);

    animationController.addListener(() {
      if (animationController.isCompleted) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return Scaffold(
      body: Container(
        color: Colors.green.shade300,
        child: Center(
          child: FadeTransition(
            opacity: animationController,
            child: CircleAvatar(

              backgroundColor: Colors.white,
              radius: 180,
              child: Center(
                child: Image.asset('assets/images/logicDev.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
