import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_scaffold.dart';

class Puck {
  const Puck();
  Future<void> init() async {
    Future.delayed(const Duration(seconds: 1), () {
      debugPrint('Puck');
    });
  }
}

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project

  @override
  void binds(i) {
    // i.singleton<HomeRepository>(HomeRepository());
    i.addSingleton(() async {
      return await const Puck().init();
    });
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const HomeScaffold());
  }
}
