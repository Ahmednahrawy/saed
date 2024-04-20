import 'package:flutter/material.dart';
import 'package:saed/screens/home_screen.dart';
import 'package:saed/screens/suppliers.dart';

class Home extends StatefulWidget {
  final int initRoute;

  const Home({super.key, required this.initRoute});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<Widget> tabs = [
    const HomeScreen(), SuppliersScreen(suppliers: [],),
  ];

  @override
  void initState() {
    _currentIndex = widget.initRoute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
    );
  }
}
