import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/add_screen/Category_add/category_add.dart';
import '../../../db/helpers/adminfunction.dart';
import '../../../login/Autotication_singup/phone_validation.dart';
import '../../../login/Autotication_singup/validation.dart';
import '../../common/snackbar.dart';
import '../profile_widgets/edit_decoration.dart';
import '../profile_widgets/inkewell_button_profile.dart';
import '../profile_widgets/profile_validation.dart';

class EditProfile extends StatefulWidget {
  final UserModel userdata;
  const EditProfile({super.key, required this.userdata});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _adminNameController;
  late TextEditingController _ventureNameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _ageController;
  final ValueNotifier<ImageData> _imageNotifier = ValueNotifier<ImageData>(
    ImageData(webImageBytes: null, imagePath: null, pickedFile: null)
  );




  @override
  void initState() {
    super.initState();
    _ventureNameController = TextEditingController(text: widget.userdata.name);
    _adminNameController =
        TextEditingController(text: widget.userdata.username);
    _phoneController = TextEditingController(text: widget.userdata.phone);
    _bioController = TextEditingController(text: widget.userdata.bio);
    _ageController = TextEditingController(text: widget.userdata.age);
   if (widget.userdata.imagePath != null && widget.userdata.imagePath!.isNotEmpty) {
    _imageNotifier.value = ImageData(
      webImageBytes: null,
      imagePath: widget.userdata.imagePath, 
      pickedFile: null
    );
  }
   
  }

  bool _validateInputs() {
    if (_adminNameController.text.isEmpty ||
        _ventureNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _bioController.text.isEmpty ||
        _ageController.text.isEmpty) {
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
            _imageNotifier.value = ImageData(
              webImageBytes: webImage, 
              imagePath: null, 
              pickedFile: pickedFile);
          } else{
            _imageNotifier.value = ImageData(
              webImageBytes: null, 
              imagePath: pickedFile.path, 
              pickedFile: pickedFile);
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

  Future<void> _saveProfile() async {
       String? updatedImagePath;
       if (kIsWeb) {
    if (_imageNotifier.value.webImageBytes != null) {
      updatedImagePath = base64Encode(_imageNotifier.value.webImageBytes!);
    } else {
      updatedImagePath = widget.userdata.imagePath;
    }
  } else {
    updatedImagePath = _imageNotifier.value.imagePath ?? widget.userdata.imagePath;
  }

    if (!_validateInputs() || _formKey.currentState?.validate() != true) {
      log("Validation failed.");
      CustomSnackBarCustomisation.show(
          context: context,
          message: "Please fill in all fields.!",
          messageColor:orange ,
          icon: Icons.info_outline_rounded,
          iconColor: orange);

      return;
    }

    bool updated = await updateUser(
      id: widget.userdata.id,
      username: _adminNameController.text,
      name: _ventureNameController.text,
      phone: _phoneController.text,
      bio: _bioController.text,
      age: _ageController.text,
      imagePath: updatedImagePath ?? widget.userdata.imagePath,
    );

    if (updated) {
      log('Updated details');
      final updatedUser = UserModel(
        id: widget.userdata.id,
        email: widget.userdata.email,
        password: widget.userdata.password,
        username: _adminNameController.text,
        name: _ventureNameController.text,
        phone: _phoneController.text,
        bio: _bioController.text,
        age: _ageController.text,
        imagePath: updatedImagePath ?? widget.userdata.imagePath,
      );
      await userBox!.put(widget.userdata.id, updatedUser);
      currentUserNotifier.value = updatedUser;

      // ignore: invalid_use_of_protected_member
      currentUserNotifier.notifyListeners();
           CustomSnackBarCustomisation.show(
          context: context,
          message: "Profile updated successfully.",
          messageColor: green,
          icon: Icons.cloud_done_outlined,
          iconColor: green);
      Navigator.pop(context);
    } else {
      log("Failed to update profile");
       CustomSnackBarCustomisation.show(
          context: context,
          message: "Profile Update failed. !",
          messageColor: redColor,
          icon: Icons.person_off_outlined,
          iconColor: redColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor:inside,
            expandedHeight: 250.0,
            pinned: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
                title:  Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.lock_open, color:whiteColor),
                      const SizedBox(width: 8),
                       Text(
                        'Edit Profile',
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                ),
                titlePadding: const EdgeInsets.only(left: 16.0, top: 16.0),
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
  Lottie.asset(
    'assets/gif/welcome 2.json',
    width: screenWidth * 0.9,
    height: screenHeight * 0.4,
  ),
  Positioned(
    child: GestureDetector(
      onTap: pickImage,
      child: SizedBox(
        width: screenWidth * 0.27,
        height: screenWidth * 0.27,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: ValueListenableBuilder<ImageData>(
              valueListenable: _imageNotifier,
              builder: (context, imageData, child) {
                ImageProvider imageProvider;
                
                if (kIsWeb) {
                  if (imageData.webImageBytes != null) {
                    imageProvider = MemoryImage(imageData.webImageBytes!);
                  } else if (widget.userdata.imagePath != null && widget.userdata.imagePath!.isNotEmpty) {
                    try {
                      imageProvider = MemoryImage(base64Decode(widget.userdata.imagePath!));
                    } catch (e) {
                      imageProvider = const AssetImage('assets/welcome/main image.jpg');
                    }
                  } else {
                    imageProvider = const AssetImage('assets/welcome/main image.jpg');
                  }
                } else {
                  if (imageData.imagePath != null) {
                    imageProvider = FileImage(File(imageData.imagePath!));
                  } else if (widget.userdata.imagePath != null && widget.userdata.imagePath!.isNotEmpty) {
                    imageProvider = FileImage(File(widget.userdata.imagePath!));
                  } else {
                    imageProvider = const AssetImage('assets/welcome/main image.jpg');
                  }
                }

                return CircleAvatar(
                  radius: screenWidth * 0.14,
                  backgroundColor: Colors.transparent,
                  backgroundImage: imageProvider,
                );
              },
            ),
          ),
        ),
      ),
    ),
  ),
]
                  ),
                )),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            EditStyle(
                              icon: Icons.person,
                              label: 'Account name',
                              controller: _adminNameController,
                              validate: NameValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              textColor:
                                  const Color.fromARGB(255, 193, 193, 193),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.business_outlined,
                              controller: _ventureNameController,
                              label: 'Venture Name',
                              validate: VentureValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              textColor:
                                  const Color.fromARGB(255, 193, 193, 193),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.phone,
                              controller: _phoneController,
                              label: 'Phone Number',
                              validate: PhoneNumberValidator.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              textColor:
                                  const Color.fromARGB(255, 193, 193, 193),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.cake,
                              controller: _ageController,
                              label: 'Age',
                              validate: AgeValidatorField.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              textColor:
                                  const Color.fromARGB(255, 193, 193, 193),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            EditStyle(
                              icon: Icons.notes,
                              controller: _bioController,
                              label: 'Bio',
                              validate: BioValidatorField.validate,
                              dividerColor:
                                  const Color.fromARGB(255, 204, 204, 204),
                              textColor:
                                  const Color.fromARGB(255, 193, 193, 193),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            InkWellButton(
                              buttomColor:
                                  inside,
                              onPressed: _saveProfile,
                              text: 'Save Changes',
                              textColor:
                                  const Color.fromARGB(255, 236, 236, 236),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
