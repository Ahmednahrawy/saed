import 'package:flutter/material.dart';

class SuppliersScreen extends StatefulWidget {
  SuppliersScreen({super.key, required this.suppliers});

  final List<String> suppliers;

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final List<String> suppliers = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('موردين'),
      ),
      body: const Center(
        child: Text('adidas'),
      ),
    );
  }
}
