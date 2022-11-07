import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: Icon(Icons.category_outlined),
      ),
    );
  }
}
