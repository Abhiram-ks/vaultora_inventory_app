import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/colors/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String animationPath;

  const MyAppBar({
    super.key,
    required this.titleText,
    required this.animationPath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 29, 66, 77),
      leading: Lottie.asset(
          animationPath,
          height: 40.0,
          width: 40.0,
        ),
      title: Text(
        titleText,
        style: TextStyle(color: textColor2),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class MyAppBarTwo extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const MyAppBarTwo({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 29, 66, 77),
      title: Text(
        titleText,
        style: TextStyle(color: textColor2),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white, 
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
