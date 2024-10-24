import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/welcome/main image.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.1,),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                ),
                height: screenHeight * 0.3,
                child: Stack(
                  children: [
                     CarouselSlider(
                       options: CarouselOptions(
                          height: screenHeight * 0.3,
                          autoPlay: true, 
                          enlargeCenterPage: true,  
                          viewportFraction: 0.7,    
                          aspectRatio: 16 / 9,
                        ),
                      items: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            child: Lottie.asset(
                              'assets/gif/welcome_vaultora.json',
                              fit: BoxFit.contain,
                              height: screenHeight * 0.6,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            child: Lottie.asset(
                              'assets/gif/Security3.json',
                              fit: BoxFit.contain,
                              height: screenHeight * 0.6,
                            ),
                          ),
                         Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(screenWidth * 0.01),
                            child: Lottie.asset(
                              'assets/gif/Animation - 1729605813184.json',
                              fit: BoxFit.contain,
                              height: screenHeight * 0.6,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: screenHeight * 0.2,
              ),
              Text(
                'Vaultora',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'An admin inventory app streamlines\n'
                'stock management, orders, and alerts\n'
                'for efficient operations.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                      child: ElevatedButton(
                        onPressed: () {
                            // Navigator. of(context).push(MaterialPageRoute(builder: (context) => LiquidSwipeScreen(),));
                        },
                        style:  ElevatedButton.styleFrom(
                          backgroundColor:const Color(0xFF3451FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                        child: const Text('Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
               SizedBox(height: screenHeight*0.02),
               Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal:  screenWidth * 0.1)),
                 const Text('Already have an account?',
                  style: TextStyle(color: Colors.white),),
                  GestureDetector(
                    onTap: (){
      
                    },
                    child:const Text(
                      '\tLogin',
                      style: TextStyle(
                        color:  Color.fromARGB(255, 0, 102, 255)
                      ),
                    ),
                  )
                ],
               ),
               SizedBox(height: screenHeight*0.11,)
            ],
          ))
        ],
      ),
    );
  }
}
