

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class ZeroStockDetails extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSwipe;
  final String titleText;
  final String descriptionText;
  final String buttonText;
  final String imagePath;

  const ZeroStockDetails({
    super.key,
    this.onTap,
    this.onSwipe,
    required this.titleText,
    required this.descriptionText,
    required this.buttonText,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      onHorizontalDragEnd: (details) {
        if (onSwipe != null) onSwipe!();
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              color: const Color(0xFFE8EDEB),
              width: double.infinity,
              height: screenHeight * 0.15,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.shopping_bag_rounded,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Container(
                            width: screenWidth * 0.2,
                            height: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                image: imagePath.isNotEmpty
                                    ? FileImage(File(imagePath))
                                        as ImageProvider
                                    : const AssetImage(
                                        'assets/welcome/main image.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Material(
                          shadowColor: Colors.black,
                          elevation: 10,
                          child: Container(
                            height: screenHeight * 0.14,
                            color: Colors.white,
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titleText,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  SizedBox(width: screenWidth * 0.02),
                                  const Text(
                                    'The product is currently out of stock. Please add stock.',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    descriptionText,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 95, 95, 95),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: screenHeight * 0.01),
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 196, 196, 196),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      buttonText,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Empty',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}