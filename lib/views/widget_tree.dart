import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/app_provider.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:flutter_application_1/views/styles/app_color.dart';
import 'package:flutter_application_1/views/widgets/navbar_widget.dart';
import 'package:go_router/go_router.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(KNavbar.pageNavBar().elementAt(selectedPage)['title']),
            actions: [
              if (KNavbar.pageNavBar().elementAt(selectedPage)['title'] !=
                      'Profile' &&
                  KNavbar.pageNavBar().elementAt(selectedPage)['title'] !=
                      'Focus')
                IconButton(
                  onPressed: () {
                    context.pushNamed('blog');
                  },
                  icon: Icon(Icons.article),
                ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {
                  // context.pushNamed('setting');
                },
                icon: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('/images/profile.jpg'),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ],
            centerTitle: true,
            leading:
                KNavbar.pageNavBar().elementAt(selectedPage)['title'] !=
                        'Profile' &&
                    KNavbar.pageNavBar().elementAt(selectedPage)['title'] !=
                        'Focus'
                ? IconButton(
                    onPressed: () {
                      context.pushNamed('list-friend');
                    },
                    icon: Icon(Icons.person_search_outlined),
                  )
                : null,
          ),
          body: KNavbar.pageNavBar().elementAt(selectedPage)['page'],
          bottomNavigationBar: NavBarWidget(),
          floatingActionButton: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.secondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {
                context.pushNamed('add-task');
              },
              icon: Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
