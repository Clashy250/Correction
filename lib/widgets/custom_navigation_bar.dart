import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLoginPressed;
  final bool isAuthenticated;
  final VoidCallback onLogoutPressed;

  const CustomNavigationBar({
    required this.title,
    required this.onLoginPressed,
    required this.isAuthenticated,
    required this.onLogoutPressed,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return AppBar(
      title: Text(title),
      actions: [
        if (!isAuthenticated)
          isWide
              ? TextButton.icon(
                  onPressed: onLoginPressed,
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: onLoginPressed,
                  tooltip: 'Login',
                )
        else
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: onLogoutPressed,
            tooltip: 'Logout',
          ),
      ],
    );
  }
}
