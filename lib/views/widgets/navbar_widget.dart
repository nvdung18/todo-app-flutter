import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/app_provider.dart';
import 'package:flutter_application_1/utils/constant.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return NavigationBar(
          destinations: [
            for (var item in KNavbar.pageNavBar())
              NavigationDestination(
                icon: Icon(item['icon']),
                label: item['title'],
              ),
          ],
          onDestinationSelected: (int index) {
            selectedPageNotifier.value = index;
          },
          selectedIndex: selectedPage, // Set the initial selected index
        );
      },
    );
  }
}
