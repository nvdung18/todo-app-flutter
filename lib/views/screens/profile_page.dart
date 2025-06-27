import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/app_provider.dart';
import 'package:flutter_application_1/utils/constant.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
      child: Text(title, style: const TextStyle(fontSize: 11)),
    );
  }

  Widget _buildProfileCard(String text) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(icon, size: 24),
            ),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
            Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileCard('5 Task Left'),
                const SizedBox(width: 4),
                _buildProfileCard('10 Task Done'),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Settings'),
                _buildSettingsItem(
                  icon: Icons.settings_outlined,
                  text: 'App Settings',
                  onTap: () {
                    context.pushNamed('setting');
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Account'),
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  text: 'Change account name',
                  onTap: () {
                    // Navigate to change name
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.key,
                  text: 'Change account password',
                  onTap: () {
                    // Navigate to change password
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.camera_alt_outlined,
                  text: 'Change account image',
                  onTap: () {
                    // Navigate to change image
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    selectedPageNotifier.value = 0;
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
