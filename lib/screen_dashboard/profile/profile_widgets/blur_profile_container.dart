import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class BlurredContainer extends StatelessWidget {
  final IconData icon; 
  final String maintext;
  final String text;
  final double sigmaX;
  final double sigmaY;
  final double? height;

  const BlurredContainer({
    super.key,
    required this.icon,
    required this.maintext,
    required this.text,
    this.sigmaX = 10.0,
    this.sigmaY = 10.0,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            maintext,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
            child: Container(
              width: double.infinity,
              height: height,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 34, 34, 34).withOpacity(0.40),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: transParent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(icon, color: grey,size: 15,),
                  SizedBox(width:screenWidth*0.03,),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


