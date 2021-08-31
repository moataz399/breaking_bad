// @dart=2.9

import 'package:bloc_app/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BreakingBadApp(
    approuter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter approuter;

  BreakingBadApp({@required this.approuter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: approuter.generateRoute,
    );
  }
}
