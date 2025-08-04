import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // import theme provider

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "sabeeh.com";
    final displayName = user?.displayName ?? "Sabeeh";

    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: TextStyle(
            color: ThemeProvider.lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ThemeProvider.primaryAmber,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: ThemeProvider.lightTextColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header with background
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ThemeProvider.primaryAmber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ThemeProvider.lightTextColor,
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeProvider.shadowColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: ThemeProvider.disabledColor.withOpacity(0.3),
                          backgroundImage: user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : null,
                          child: user?.photoURL == null
                              ? Icon(
                                  Icons.person,
                                  size: 50,
                                  color: ThemeProvider.primaryAmber,
                                )
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ThemeProvider.cardColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: ThemeProvider.shadowColor.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: ThemeProvider.primaryAmber,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    displayName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: ThemeProvider.lightTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 16,
                      color: ThemeProvider.lightTextColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Stats row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat("2", "Pets"),
                        _buildStatDivider(),
                        _buildStat("5", "Favorites"),
                        _buildStatDivider(),
                        _buildStat("1", "Adoptions"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Account Settings",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeProvider.lightTextColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
          _buildSettingItem(
            icon: Icons.edit,
            title: "Edit Profile",
            onTap: () {}, // implement later
          ),
          _buildSettingItem(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () {}, // implement later
          ),
          _buildSwitchItem(
            icon: Icons.notifications,
            title: "Notifications",
            value: true,
            onChanged: (value) {}, // implement later
          ),
          _buildSwitchItem(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Support",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ThemeProvider.lightTextColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildSettingItem(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {}, // implement later
          ),
          _buildSettingItem(
            icon: Icons.privacy_tip_outlined,
            title: "Privacy Policy",
            onTap: () {}, // implement later
          ),
          _buildSettingItem(
            icon: Icons.info_outline,
            title: "About Us",
            onTap: () {}, // implement later
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          FirebaseAuth.instance.signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeProvider.errorColor,
                        ),
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeProvider.errorColor.withOpacity(0.1),
                foregroundColor: ThemeProvider.errorColor,
                elevation: 0,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(Icons.logout),
              label: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ThemeProvider.lightTextColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: ThemeProvider.lightTextColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: ThemeProvider.lightTextColor.withOpacity(0.3),
    );
  }

  Widget _buildSettingItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeProvider.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ThemeProvider.shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: ThemeProvider.primaryAmber),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchItem({required IconData icon, required String title, required bool value, required Function(bool) onChanged}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeProvider.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ThemeProvider.shadowColor.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: ThemeProvider.primaryAmber),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        value: value,
        activeColor: ThemeProvider.primaryAmber,
        onChanged: onChanged,
      ),
    );
  }
}
