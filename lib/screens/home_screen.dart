import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saed/providers/theme_provider.dart';
import 'package:saed/screens/order_screen.dart';
import 'package:saed/screens/side_nav.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final appThemeState = ref.watch(appThemeStateNotifier);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('سَاعٍدْ'),
        centerTitle: true,
        actions: [
          Switch(
            // activeColor: Colors.black,
            value: appThemeState.isDarkModeEnabled,
            onChanged: (enabled) {
              if (enabled) {
                appThemeState.setDarkTheme();
              } else {
                appThemeState.setLightTheme();
              }
            },
          ),
        ],
      ),
      drawer: const SideNav(),
      body: const Orderscreen(),
    );
  }
}
