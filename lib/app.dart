import 'package:flutter/material.dart';
import 'package:jogo_da_velha/provider/theme.dart';
import 'package:provider/provider.dart';
import './pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: themeProvider.selectedPrimaryColor,
      ),
      home: const HomePage(),
    );
  }
}