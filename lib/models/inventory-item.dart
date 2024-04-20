import 'package:saed/models/sales/customer.dart';
import 'package:saed/models/supply/Supplier.dart';

class InventoryItem {
  final String name;
  final int quantity;
  final double cost;
  final Supplier? supplier;
  final Customer? customer;
  final int minOQ;
  // Optionally, consider adding
  // - image asset

  InventoryItem(
    this.minOQ, {
    required this.name,
    required this.quantity,
    required this.cost,
    this.supplier,
    this.customer,
  });
}
