import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/providers/user_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/100',
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileField(
                  context,
                  'Name',
                  userProvider.name,
                  Icons.person,
                  () => _showEditDialog(
                    context,
                    'Name',
                    userProvider.name,
                    (newValue) => userProvider.updateName(newValue),
                  ),
                ),
                _buildProfileField(
                  context,
                  'Email',
                  userProvider.email,
                  Icons.email,
                  () => _showEditDialog(
                    context,
                    'Email',
                    userProvider.email,
                    (newValue) => userProvider.updateEmail(newValue),
                  ),
                ),
                _buildProfileField(
                  context,
                  'Phone Number',
                  userProvider.phoneNumber,
                  Icons.phone,
                  () => _showEditDialog(
                    context,
                    'Phone Number',
                    userProvider.phoneNumber,
                    (newValue) => userProvider.updatePhoneNumber(newValue),
                  ),
                ),
                _buildProfileField(
                  context,
                  'Driver License',
                  userProvider.driverLicense,
                  Icons.card_membership,
                  () => _showEditDialog(
                    context,
                    'Driver License',
                    userProvider.driverLicense,
                    (newValue) => userProvider.updateDriverLicense(newValue),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement logout functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout functionality to be implemented'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Logout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileField(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Theme.of(context).primaryColor),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(value, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Icon(Icons.edit, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String label,
    String currentValue,
    Function(String) onSave,
  ) {
    final TextEditingController controller = TextEditingController(
      text: currentValue,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $label'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
