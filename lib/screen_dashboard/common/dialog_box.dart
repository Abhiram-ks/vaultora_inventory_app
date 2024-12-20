import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

import '../../Color/colors.dart';
import '../../splash_and_welcome/welcome_screen.dart';

class DialogBox {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  child: Lottie.asset(
                    'assets/gif/logout_lottie.json',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: grey),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No', style: TextStyle(color: textColor2)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black,
                          ),
                          onPressed: () async {
                            await logout(context);
                          },
                          child:
                              Text('Yes', style: TextStyle(color: textColor2)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  static Future<void> logout(BuildContext context) async {
    var sessionBox = await Hive.openBox('sessionBox');
    await sessionBox.delete('lastLoggedUser');
    Navigator.of(context).pop();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const CheckScreen(),
      ),
      (route) => false,
    );
  }
}
