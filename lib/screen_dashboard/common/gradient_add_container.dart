
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:readmore/readmore.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final List<Color> gradientColors1;
  final List<Color> gradientColors2;
  final String lottieFile;
  final double right;
  final double bottom;
  final double lottieSize;
   final VoidCallback onTap;
  final String description; 

  const CustomContainer({
    super.key,
    required this.title,
    required this.gradientColors1,
    required this.gradientColors2,
    required this.lottieFile,
    required this.right,
    required this.bottom,
    required this.lottieSize,
    required this.onTap,
    required this.description,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  bool _isFirstGradient = true;
  bool _isDisposed = false; 
  

  @override
  void initState() {
    super.initState();
    loadGradient();
    
  }
    @override
  void dispose() {
    _isDisposed = true; 
    super.dispose();
  }
  

  void loadGradient() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 3));
      if (_isDisposed) return false;
      setState(() {
        _isFirstGradient = !_isFirstGradient;
      });
      return true;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, 
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: ColorTween(
          begin: _isFirstGradient
              ? widget.gradientColors1[0]
              : widget.gradientColors2[0],
          end: _isFirstGradient
              ? widget.gradientColors2[0]
              : widget.gradientColors1[0],
        ),
        builder: (context, Color? color1, child) {
          return TweenAnimationBuilder(
            duration: const Duration(seconds: 3),
            tween: ColorTween(
              begin: _isFirstGradient
                  ? widget.gradientColors1[1]
                  : widget.gradientColors2[1],
              end: _isFirstGradient
                  ? widget.gradientColors2[1]
                  : widget.gradientColors1[1],
            ),
            builder: (context, Color? color2, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.23,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1!, color2!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    Positioned(
                      right: widget.right,
                      bottom: widget.bottom,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Lottie.asset(
                          widget.lottieFile,
                          fit: BoxFit.cover,
                          width: widget.lottieSize,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.only(left: 25, top: 25),
                        child: Text(
                          widget.title,
                          style: GoogleFonts.kodchasan(
                            fontSize: 19,
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.3, 
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ReadMoreText(
                                widget.description,
                                trimLines: 2,
                                colorClickableText: blue,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read more',
                                trimExpandedText: 'Show less',
                                style: GoogleFonts.kodchasan(
                                  fontSize: 15,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                lessStyle:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blue,
                                ),
                                moreStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}