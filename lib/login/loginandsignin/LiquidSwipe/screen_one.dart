import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/login/loginSignin/welcome_screen.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 42, 255, 188),
                  Color.fromRGBO(195, 255, 149, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Lottie.asset(
                  'assets/gif/welcome_vaultora.json',
                  fit: BoxFit.contain,
                  height: size.height * 0.6,
                ),
              const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        '"Offer seamless solutions to track stock levels."\n'
                        '"Time is what we want most, but what we use worst."',
                        textAlign: TextAlign.center, // Center align text
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
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
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CheckScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                 const Text(
                    'swipe->',
                    style: TextStyle(
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
