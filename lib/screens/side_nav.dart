import 'package:flutter/material.dart';
import 'package:saed/screens/home.dart';
import 'package:saed/screens/splash_screen.dart';
import 'package:saed/widgets/textbuilder.dart';

class SideNav extends StatefulWidget {
  const SideNav({super.key});

  @override
  State<SideNav> createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  static bool isCollapse = false;
  final drawer = DrawersController();
  void collapseDrawer() {
    setState(() {
      isCollapse = !isCollapse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: isCollapse ? 90 : 180,
      child: Material(
        child: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isCollapse
                      ? Container(
                          height: 80.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black45,
                              offset: Offset(2.0, 2.0),
                            )
                          ], color: Colors.white),
                          child: const Center(
                            child: ListTile(
                              leading: CircleAvatar(
                                maxRadius: 20.0,
                                backgroundColor: Colors.black,
                                child: TextBuilder(text: 'Logo'),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 100.0,
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black45,
                                    offset: Offset(5.0, 5.0),
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white),
                            child: const Center(
                              child: ListTile(
                                leading: CircleAvatar(
                                  maxRadius: 30.0,
                                  backgroundColor: Colors.black,
                                  child: TextBuilder(text: 'Logo'),
                                ),
                                title: TextBuilder(
                                  text: 'إسم الشركة',
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.center,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 10.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: drawer.drawer.length,
                    itemBuilder: (BuildContext context, int i) {
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Home(
                                        initRoute: i,
                                      )),
                              (route) => false);
                        },
                        leading: Icon(
                          drawer.drawer[i].icon,
                          color: Colors.black,
                        ),
                        title: isCollapse
                            ? null
                            : TextBuilder(
                                text: drawer.drawer[i].title,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                      );
                    },
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const Splash()),
                          (route) => false);
                    },
                    leading: const Icon(
                      Icons.power_settings_new,
                      color: Colors.black,
                    ),
                    title: isCollapse
                        ? null
                        : const TextBuilder(
                            text: 'Log out',
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                  ),
                  IconButton(
                      onPressed: collapseDrawer,
                      icon: isCollapse
                          ? const Icon(Icons.arrow_forward_ios)
                          : const Icon(Icons.arrow_back_ios))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawersController {
  final drawer = [
    DrawerModel('الرئيسية', Icons.home),
    DrawerModel('موردين', Icons.receipt_long),
    DrawerModel('عملاء', Icons.account_balance),
    DrawerModel('مخزون', Icons.person),
    DrawerModel('إعدادات', Icons.settings),
    // DrawerModel('Share App', Icons.share),
  ];
}

class DrawerModel {
  final String? title;
  final IconData? icon;

  DrawerModel(this.title, this.icon);
}
