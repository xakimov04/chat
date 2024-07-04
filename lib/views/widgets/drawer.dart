import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TelegramDrawer extends StatelessWidget {
  const TelegramDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('user.email@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              // Navigate to new group screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Secret Chat'),
            onTap: () {
              // Navigate to secret chat screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              // Navigate to new channel screen
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Contacts'),
            onTap: () {
              // Navigate to contacts screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('Calls'),
            onTap: () {
              // Navigate to calls screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text('Log Out'),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
    );
  }
}
