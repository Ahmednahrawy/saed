import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saed/models/product_model.dart';
import 'package:saed/utils/utils.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceScreen extends StatefulWidget {
  InvoiceScreen({
    super.key,
    required this.products,
    required this.totalCost,
    required this.customerName,
    required this.paid,
    required this.rest,
  });

  final String customerName;
  final List<Product> products;
  final double totalCost;
  final double paid;
  final double rest;

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  PrintingInfo? printingInfo;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final info = await Printing.info();

    setState(() {
      printingInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        const PdfPreviewAction(
          icon: Icon(Icons.save),
          onPressed: saveAsFile,
        )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('فاتورة العميل'),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        actions: actions,
        // onPrinted: showPrintedToast,
        // onShared: showSharedToast,
        build: (format) => generatePDF(
          format,
          widget.products,
          widget.totalCost,
          widget.customerName,
          widget.paid,
          widget.rest,
        ),
      ),
    );
  }
}
