import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});

  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.draw_outlined, size: 30),
                Text('Dark Mode', style: Theme.of(context).textTheme.bodyLarge),
                Spacer(),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Logout', style: Theme.of(context).textTheme.bodyLarge),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    onLogoutPress(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onLogoutPress(BuildContext context) async {
    // Handle logout logic here
    // For example, clear user data, navigate to login page, etc.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(KConstants.signInKey, false);
    context.go('/');
  }
}
