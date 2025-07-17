import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/menu_item.dart';

class DrawerMenu extends StatelessWidget {
  final List<MenuItem> menuItems;

  const DrawerMenu({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(context),
            ...menuItems.map((item) => _buildMenuItem(context, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.teal,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=3',
            ),
          ),
          SizedBox(width: 16),
          Text(
            "Hello, User!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    return ListTile(
      leading: Icon(item.icon, color: Colors.teal),
      title: Text(item.title),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${item.title} selected")),
        );
      },
      hoverColor: Colors.teal.shade100,
    );
  }
}