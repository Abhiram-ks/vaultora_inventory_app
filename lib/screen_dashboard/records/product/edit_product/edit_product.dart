import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/product/add.dart';

import '../../../../db/helpers/addfunction.dart';
import '../../../add_screen/Category_add/category_add.dart';
import '../../../common/snackbar.dart';
import '../../../profile/profile_widgets/edit_decoration.dart';
import '../product_records/subfiles_product_reocrd/check_out.dart';
import '../product_records/subfiles_product_reocrd/digitfiled.dart';
import '../product_records/subfiles_product_reocrd/drop_down.dart';
import '../filtering_product/filed_decoration.dart';


class CustomBottomSheet extends StatefulWidget {
  final AddModel item;
  const CustomBottomSheet({super.key, required this.item});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _itemNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _itemCountController;
  late TextEditingController _mrpController;
  late TextEditingController _purchasePriceController;
  late ValueNotifier<String?> _selectedCategoryNotifier;
  final ValueNotifier<ImageData>   _imagePathNotifier = ValueNotifier<ImageData>(
    ImageData(webImageBytes: null, imagePath: null, pickedFile: null),
  );
  final ValueNotifier<String> selectedImagePath = ValueNotifier<String>('');


  @override
  void initState() {
    super.initState();
    _selectedCategoryNotifier = ValueNotifier<String>(widget.item.dropDown);
    _itemNameController = TextEditingController(text: widget.item.itemName);
    _descriptionController =
        TextEditingController(text: widget.item.description);
    _itemCountController = TextEditingController(text: widget.item.itemCount);
    _mrpController = TextEditingController(text: widget.item.mrp);
    _purchasePriceController = TextEditingController(text: widget.item.mrp);
    if (widget.item.imagePath.isNotEmpty) {
      _imagePathNotifier.value = ImageData(
        webImageBytes: null,
         imagePath: widget.item.imagePath,
          pickedFile: null);
          selectedImagePath.value = widget.item.imagePath;
    }
  }

  bool _validateInputsitems() {
    if (_itemCountController.text.isEmpty ||
        _purchasePriceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _itemCountController.text.isEmpty ||
        _mrpController.text.isEmpty) {
      log("Please fill in all fields.");
      return false;
    }
    return true;
  }

  Future<void> pickImage() async{
     final picker = ImagePicker();

     try {
       final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        imageQuality: 80,
        );
        if(pickedFile != null) {
          if (kIsWeb) {
            final webImage = await pickedFile.readAsBytes();
            _imagePathNotifier.value = ImageData(
              webImageBytes: webImage, 
              imagePath: null, 
              pickedFile: pickedFile);
              selectedImagePath.value =  base64Encode(webImage);
          } else{
            _imagePathNotifier.value = ImageData(
              webImageBytes: null, 
              imagePath: pickedFile.path, 
              pickedFile: pickedFile);
              selectedImagePath.value = pickedFile.path;
          } 
        } else {
           CustomSnackBarCustomisation.show(
          context: context,
          message: "Please select an image to proceed",
          messageColor: orange,
          icon: Icons.image_search_sharp,
          iconColor: orange,
        );
        }
     } catch (e) {
        CustomSnackBarCustomisation.show(
        context: context,
        message: "Image Selection Error",
        messageColor: redColor,
        icon: Icons.photo_size_select_large_sharp,
        iconColor: redColor,
      );
     }  
  }

// _imagePathNotifier.value = pickedFile.path;
  Future<void> _updateItem() async {
    String updatedImagePath = selectedImagePath.value;
    if (!_validateInputsitems() || _formKey.currentState?.validate() != true) {
      log("Validation faild.");
      CustomSnackBarCustomisation.show(
          context: context,
          message: "Please fill in all fields.",
          messageColor: redColor,
          icon: Icons.warning,
          iconColor: redColor);
      return;
    }
    bool updatedItem = await updateItem(
      id: widget.item.id,
      itemName: _itemNameController.text,
      description: _descriptionController.text,
      itemCount: _itemCountController.text,
      mrp: _mrpController.text,
      imagePath: updatedImagePath,
      dropDown: _selectedCategoryNotifier.value ?? widget.item.dropDown,
      purchaseRate: _purchasePriceController.text,
    );
    if (updatedItem) {
      log('Update details');
      final updatedItems = AddModel(
          id: widget.item.id,
          userid: widget.item.userid,
          itemName: _itemNameController.text,
          description: _descriptionController.text,
          purchaseRate: _purchasePriceController.text,
          mrp: _mrpController.text,
          dropDown: _selectedCategoryNotifier.value ?? widget.item.imagePath,
          itemCount: _itemCountController.text,
          totalPurchase: widget.item.totalPurchase,
          imagePath: updatedImagePath);
      await addBox!.put(widget.item.id, updatedItems);

      currentiteamNotifier.value = updatedItems;
      // ignore: invalid_use_of_protected_member
      currentiteamNotifier.notifyListeners();
      CustomSnackBarCustomisation.show(
          context: context,
          message: "Item updated successfully.",
          messageColor: green,
          icon: Icons.cloud_done_outlined,
          iconColor: green);
      Navigator.pop(context);
    } else {
      log("Failed to update item");
        CustomSnackBarCustomisation.show(
          context: context,
          message:'Update failed. !',
          messageColor: redColor,
          icon: Icons.warning,
          iconColor: redColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 30, 59, 67),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.004),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 80.0,
                    height: 2.0,
                    color: transParent,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset(
                      'assets/gif/welcome 2.json',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.4,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Animation not found');
                      },
                    ),
                    Positioned(
              child: ValueListenableBuilder<ImageData>(
  valueListenable: _imagePathNotifier,
  builder: (context, imageData, child) {
    ImageProvider? imageProvider;

    if (kIsWeb) {
      if (imageData.webImageBytes != null) {
        imageProvider = MemoryImage(imageData.webImageBytes!);
      } else if (widget.item.imagePath.isNotEmpty) {
        try {
          imageProvider = MemoryImage(base64Decode(widget.item.imagePath));
        } catch (e) {
          imageProvider = const AssetImage('assets/welcome/main image.jpg');
        }
      } else {
        imageProvider = const AssetImage('assets/welcome/main image.jpg');
      }
    } else {
      if (imageData.imagePath != null) {
        imageProvider = FileImage(File(imageData.imagePath!));
      } else if (widget.item.imagePath.isNotEmpty) {
        imageProvider = FileImage(File(widget.item.imagePath));
      } else {
        imageProvider = const AssetImage('assets/welcome/main image.jpg');
      }
    }

    return GestureDetector(
      onTap: pickImage,
      child: CircleAvatar(
        radius: screenWidth * 0.14,
        backgroundColor: Colors.transparent,
        backgroundImage: imageProvider,
      ),
    );
  },
)

                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EditStyle(
                              icon: Icons.shopping_bag_outlined,
                              label: 'Item name',
                              controller: _itemNameController,
                              validate: InputValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 106, 106, 106),
                              textColor: const Color.fromARGB(255, 70, 70, 70),
                            ),
                            SizedBox(height: screenHeight * 0.003),
                            EditStyle(
                              icon: Icons.description_outlined,
                              label: 'Description',
                              controller: _descriptionController,
                              validate: InputValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 111, 111, 111),
                              textColor:
                                  const Color.fromARGB(255, 101, 101, 101),
                            ),
                            SizedBox(height: screenHeight * 0.003),
                            EditStyle(
                              icon: Icons.price_change,
                              label: 'Purchase Rate',
                              controller: _purchasePriceController,
                              validate: InputValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 106, 106, 106),
                              textColor: const Color.fromARGB(255, 70, 70, 70),
                            ),
                            SizedBox(height: screenHeight * 0.003),
                            DropDown(
                              height: screenHeight * 0.065,
                              hintText: 'Category',
                              selectedCategoryNotifier:
                                  _selectedCategoryNotifier,
                            ),
                            SizedBox(height: screenHeight * 0.003),
                            EditStyle(
                              icon: Icons.inventory,
                              label: 'Stock level',
                              controller: _itemCountController,
                              validate: DigitInputValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 133, 133, 133),
                              textColor: const Color.fromARGB(255, 95, 95, 95),
                            ),
                            SizedBox(height: screenHeight * 0.003),
                            EditStyle(
                              icon: Icons.monetization_on,
                              label: 'MRP',
                              controller: _mrpController,
                              validate: DigitInputValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 123, 123, 123),
                              textColor: const Color.fromARGB(255, 90, 90, 90),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            CheckOut(
                              hintText: 'Conform Update',
                              height: screenHeight * 0.06,
                              color: const Color.fromARGB(255, 29, 66, 77),
                              onTap: _updateItem,
                            ),
                            SizedBox(height: screenHeight * 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                const Center(
                  child: Text(
                    'Swipe down',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
