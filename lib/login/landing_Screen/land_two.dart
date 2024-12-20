import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

import '../validation_login/orline_dec.dart';


class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
     final screenTwo= ScreenColor(colors: [
    const Color.fromARGB(255, 224, 248, 88),
    const Color.fromARGB(255, 139, 240, 137),
    ]);
    return Scaffold(
      body: Stack(
        children: [
          Container(
           decoration: screenTwo.gradientDecoration,
            child: Column(
              children: [
                SizedBox(height: size.height  * 0.02),
                Lottie.asset(
                  'assets/gif/Animation - 1729708868342.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child:  Text(
                        '"Privacy is a promise—secure the data like it’s your own And build trust."\n'
                        '"by being transparent with every action you take."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          fontFamily: 'Courier',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
         Positioned(
            top: size.height * 0.9,
            left: size.width * 0.1,
            child: SizedBox(
              width: size.width * 0.8,
              child:Row(
                children: [
                   const Spacer(),
                   Align(
                    alignment: Alignment.bottomRight,
                    child:  Text(
                      'swipe->',
                      style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}