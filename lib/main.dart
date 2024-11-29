import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vaultora_inventory_app/db/functions/addfunction.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/add/add.dart';
import 'package:vaultora_inventory_app/db/models/category/catalog.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'db/functions/adminfunction.dart';
import 'db/functions/categoryfunction.dart';
import 'db/models/user/user.dart';
import 'log/splash_welcom/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(AddModelAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  Hive.registerAdapter(SaleProductAdapter());
  await initUserDB();
  await initCategoryDB();
  await initAddDB();
  await initSalesDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaultora',
      theme: ThemeData(
        useMaterial3: true,
       primarySwatch: Colors.blue,
       brightness: Brightness.light,
       scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}
