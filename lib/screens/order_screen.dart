import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:saed/screens/invoice_screen.dart';
import 'package:saed/utils/helper_date_price.dart';
import 'package:saed/utils/helper_widgets.dart';
import 'package:saed/models/product_model.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:saed/widgets/button.dart';
import 'package:saed/widgets/data_table.dart';

class Orderscreen extends StatefulWidget {
  const Orderscreen({super.key});

  @override
  State<Orderscreen> createState() => _OrderscreenState();
}

class _OrderscreenState extends State<Orderscreen> {
  String? formattedDate;
  bool isPurchaseButtonPressed = false;
  bool isSellButtonPressed = false;
  bool isStorageButtonPressed = false;
  final List<Product> products = [];
  // format date now
  late DateTime selectedDate;

  final List<String> suppliers = [];

  String? _action;
  final TextEditingController _customerNameController = TextEditingController();
  final GlobalKey<FormState> _dropdownSearchKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final _payKey = GlobalKey<FormState>();
  final _packageNumberController = TextEditingController();
  final _packageWeightController = TextEditingController();
  final _priceController = TextEditingController();
  final _payController = TextEditingController();
  final List _productList = [
    'صعيدي',
    'أرضيات',
    'منشر',
    'فريحي 0',
    'فريحي 1',
    'فريحي 2',
    'فريحي 3',
    'ارغاون',
    'عزاوي',
    'علف',
    'عجيزي',
    'حامض',
    'زيتون زيت',
    'زيت',
    'زيت وطيجن',
    'علب 10ك',
    'علب 5ك',
    'علب 800',
    'علب 700',
    'علب 1.4ك',
    'علب 1.6ك',
    'حامض زج. 650جم ',
    'عجيزي زج. 650جم',
    'دولسي زج. 650جم',
    'كلاماتا زج. 650جم',
  ];

  String? _selectedProduct;
  final _weightController = TextEditingController();

  @override
  void initState() {
    _packageWeightController.text = "2";
    _packageNumberController.text = "0";
    super.initState();
  }

  void submitForm(List<Product> products) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => InvoiceScreen(
          products: products,
          totalCost: _totalCost,
          customerName: '${_customerNameController.text}',
          paid: double.parse(_payController.text),
          rest: _rest,
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    formattedDate = Utils.formatDate(selectedDate);
    setState(() {
      selectedDate;
    });
  }

  double get _totalCost => products.fold(
        0,
        (sum, product) =>
            sum +
            (product.weight - (product.packageWeight * product.numberPackage)) *
                (product.action == "شراء"
                    ? product.price
                    : (-1 * product.price)),
      );
  double get _rest {
    return _totalCost - double.parse(_payController.text);
  }

  // Add product function
  void _addProduct() {
    // final action =
    if (_formKey.currentState!.validate()) {
      setState(() {
        products.add(
          Product(
            name: _selectedProduct!,
            weight: double.parse(_weightController.text),
            packageWeight: double.parse(_packageWeightController.text),
            price: double.parse(_priceController.text),
            numberPackage: int.parse(_packageNumberController.text),
            action: _action!,
          ),
        );
        suppliers.add(_customerNameController.text);
      });
      // _productController.clear();
      _weightController.clear();
      // _packageWeightController.clear();
      // _priceController.clear();
      // _packageNumberController.clear();
      _selectDate(context); // Update the selected date when adding a product
    }
  }

// activity button active color
  void _activeTextButton(String buttonType) {
    setState(() {
      // Set the corresponding button as pressed
      isStorageButtonPressed = buttonType == 'تخزين';
      isSellButtonPressed = buttonType == 'بـيع';
      isPurchaseButtonPressed = buttonType == 'شراء';
    });
  }

  @override
  Widget build(BuildContext context) {
//  pressed text button style
    // TextStyle pressedStyle = TextStyle
    ButtonStyle pressedButtonStyle = ButtonStyle(
      foregroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Theme.of(context).colorScheme.onBackground;
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.brightness == Brightness.light
              ? const Color.fromARGB(255, 181, 203, 228)
              : const Color.fromARGB(255, 19, 51, 157);
        },
      ),
    );
    // default text button style
    ButtonStyle defaultButtonStyle = ButtonStyle(
      foregroundColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        return Colors.white;
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Theme.of(context).colorScheme.brightness == Brightness.light
              ? const Color.fromARGB(
                  255, 29, 62, 192) // Default background color
              : const Color.fromARGB(
                  255, 60, 13, 117); // Default background color for dark theme
        },
      ),
    );

    // media query size
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      // Send data button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          submitForm(products);
        },
        child: const Icon(
          Icons.picture_as_pdf_outlined,
          size: 28,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 0,
        shape: CircularNotchedRectangle(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            width: screenSize.width * 0.95,
            height: screenSize.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Customer name

                        Card(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              controller: _customerNameController,
                              decoration: const InputDecoration(
                                labelText: "إسم العميل",
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 5) {
                                  return 'Please enter at least 4 characters.';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),

                        addVerticalSpace(5),
                        // main activity buy,sell, store
                        Card(
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('تخزين');
                                    _action = 'تخزين';
                                  },
                                  child: const Text(
                                    'تخزين',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  style: isStorageButtonPressed
                                      ? pressedButtonStyle
                                      : defaultButtonStyle,
                                ),
                                addHorizontalSpace(5),
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('بـيع');
                                    _action = 'بـيع';
                                  },
                                  child: const Text(
                                    'بـيع',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  style: isSellButtonPressed
                                      ? pressedButtonStyle
                                      : defaultButtonStyle,
                                ),
                                addHorizontalSpace(5),
                                TextButton(
                                  onPressed: () {
                                    _activeTextButton('شراء');
                                    _action = 'شراء';
                                  },
                                  child: const Text(
                                    'شراء',
                                    style: TextStyle(fontSize: 23),
                                  ),
                                  style: isPurchaseButtonPressed
                                      ? pressedButtonStyle
                                      : defaultButtonStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Product selection
                        DropdownSearch(
                          key: _dropdownSearchKey,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          items: _productList,
                          selectedItem: _selectedProduct,
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'المنتج',
                              suffixIcon: Icon(Icons.search),
                              hintText: 'Search',
                            ),
                          ),
                          popupProps: const PopupProps.bottomSheet(
                            bottomSheetProps: BottomSheetProps(
                              elevation: 16,
                              backgroundColor: Color(0xFFAADCEE),
                            ),
                            showSearchBox: true,
                          ),
                          onChanged: (value) {
                            setState(() {
                              // _productController.text = value;
                              _selectedProduct = value;
                            });
                          },
                        ),
                        // Package weight
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Weight
                              Flexible(
                                flex: 4,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: _weightController,
                                    decoration: const InputDecoration(
                                      labelText: 'الوزن أو العدد',
                                      suffixText: 'kg',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter weight.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              addHorizontalSpace(10),
                              // package weight
                              Flexible(
                                flex: 2,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: _packageWeightController,
                                    decoration: const InputDecoration(
                                      labelText: 'وزن العبوة',
                                      suffixText: 'kg',
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'أدخل وزن   \n العبوة الفارغة';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              addHorizontalSpace(10),
                              // number of packages
                              Flexible(
                                flex: 3,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextFormField(
                                    controller: _packageNumberController,
                                    decoration: const InputDecoration(
                                      labelText: 'عدد العبوات',
                                    ),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'أدخل عدد العبوات أولا';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // price
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: _priceController,
                            decoration: const InputDecoration(
                              labelText: 'السعر',
                              suffixText: 'L.E',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price.';
                              }
                              return null;
                            },
                          ),
                        ),
                        addVerticalSpace(10),
                        // Add product button
                        GradientButtonFb1(
                          text: 'أضف منتج',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addProduct();
                            }
                          },
                        ),
                        addVerticalSpace(10),
                        Text(
                          formattedDate ?? 'أكمل بيانات المنتج أولا',
                          style: const TextStyle(color: Colors.redAccent),
                        ), //print date here
                        addVerticalSpace(10),
                        // Products table
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: MyDataTable(products: products)),

                        // Total cost
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Total cost: $_totalCost L.E   '),
                            addHorizontalSpace(10),
                            Text('paid: ${_payController.text} L.E'),
                            addHorizontalSpace(10),
                            // Text('Rest: $_rest L.E'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(10),
                  Form(
                    key: _payKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: _payController,
                        decoration: const InputDecoration(
                          labelText: 'تحصيل',
                          suffixText: 'L.E',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
