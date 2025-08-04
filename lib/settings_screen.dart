import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: ThemeProvider.lightTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ThemeProvider.primaryAmber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Settings Section
            _buildSectionHeader("App Settings"),
            _buildSettingItem(
              icon: Icons.dark_mode,
              title: "Dark Mode",
              subtitle: "Change app appearance",
              trailing: Switch(
                value: themeProvider.isDarkMode,
                activeColor: ThemeProvider.primaryAmber,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ),
            _buildSettingItem(
              icon: Icons.notifications,
              title: "Notifications",
              subtitle: "Manage notification preferences",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.language,
              title: "Language",
              subtitle: "English (US)",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            
            // Account Settings Section
            _buildSectionHeader("Account Settings"),
            _buildSettingItem(
              icon: Icons.person,
              title: "Profile Information",
              subtitle: "Manage your personal details",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.lock,
              title: "Security",
              subtitle: "Password and authentication",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.privacy_tip,
              title: "Privacy",
              subtitle: "Manage data and permissions",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            
            // Support Section
            _buildSectionHeader("Support"),
            _buildSettingItem(
              icon: Icons.help_outline,
              title: "Help Center",
              subtitle: "Get help with the app",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.feedback,
              title: "Send Feedback",
              subtitle: "Help us improve the app",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            _buildSettingItem(
              icon: Icons.info_outline,
              title: "About",
              subtitle: "App version and information",
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            
            SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete Account"),
                      content: Text("Are you sure you want to delete your account? This action cannot be undone."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Implement account deletion
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeProvider.errorColor,
                          ),
                          child: Text("Delete"),
                        ),
                      ],
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: ThemeProvider.errorColor,
                ),
                child: Text(
                  "Delete Account",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ThemeProvider.lightTextColor,
        ),
      ),
    );
  }
  
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ThemeProvider.primaryAmber.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ThemeProvider.primaryAmber, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: ThemeProvider.secondaryTextColor),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
