import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'sales_record/sale_record.dart';

class SalesCategory extends StatefulWidget {
  final String volule;
  const SalesCategory({super.key, required this.volule});

  @override
  State<SalesCategory> createState() => _SalesCategoryState();
}

class _SalesCategoryState extends State<SalesCategory> {
  
  void _navigateToSalesRecord(){
     Navigator.of(context).push(
    PageRouteBuilder(
     transitionDuration: const Duration(milliseconds: 500),
     pageBuilder: (context, animation, secondaryAnimation) =>  const SalesData(),
     transitionsBuilder: (context, animation, secondaryAnimation, child) {
       const begin = Offset(1.0, 0.0);
       const end = Offset.zero;
       const curve = Curves.ease;
       var tween =Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation,
      child: child,
      );
     },
  )
    
  );
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
        onHorizontalDragEnd: (details) {
    if (details.primaryVelocity! < 0) {
      _navigateToSalesRecord();
    }
  },
  onTap: _navigateToSalesRecord,
      child: Container(
        width: double.infinity,
        height: screenHeight * 0.21,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 134, 134, 134),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 3, left: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sales Data',
                          style: GoogleFonts.kodchasan(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        ReadMoreText(
                          'information about sold products, revenue.. '
                          'Detailed analysis helps in understanding customer preferences and purchasing patterns, '
                          'allowing for more tailored marketing strategies and inventory management.',
                          trimLines: 2,
                          colorClickableText: inside,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Read more',
                          trimExpandedText: 'Show less',
                          style: GoogleFonts.kodchasan(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          lessStyle:  TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:inside,
                          ),
                          moreStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: inside,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(  
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.04,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color.fromARGB(255, 134, 134, 134),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                children: [
                                  
                               const Icon(Icons.description_outlined,color: Colors.black,),
                                const SizedBox(width: 5,),
                                Text(
                            'Volume',
                            style: GoogleFonts.kodchasan(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                            const SizedBox(width: 8,),
                          Text(
                            widget.volule,
                            style: GoogleFonts.kodchasan(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                                ],
                                
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
                 const SizedBox(width: 1),
                 Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/listimage/file.png',
                    height: 110.0,
                    width: 110.0,
                    fit: BoxFit.cover,
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