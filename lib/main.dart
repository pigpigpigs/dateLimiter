import 'package:flutter/material.dart';
import 'package:food_limmit_controller/config/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///やること
///選択したアイテムを一括で削除で切るようにしたい

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
