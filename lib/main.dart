import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/features/auth/providers/auth_provider.dart';
import 'package:ride_lanka/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: AppRoutes.routes,
      initialRoute: AppRoutes.splash,
    );
  }
}
