import 'package:saed/models/supply/supply.dart';

class Supplier {
  final String name;
  final String contactInfo;
  final List<Supply> supplies; // List of provided supplies
  final String address;
  final String emailAddress;
  final String notes;

  Supplier(
    this.address,
    this.emailAddress,
    this.notes, {
    required this.name,
    required this.contactInfo,
    this.supplies = const [],
  });
}
