import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/models/user/user.dart';
import 'package:vaultora_inventory_app/screen_dashboard/profile/profile_widgets/inkewell_button_profile.dart';
import 'package:vaultora_inventory_app/screen_dashboard/profile/profile_widgets/blur_profile_container.dart';
import '../../../Color/colors.dart';
import '../../../db/helpers/adminfunction.dart';
import '../../settings/list_settings_contier.dart';
import '../edit_profile/edit_profille.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userDetails});
  final UserModel userDetails;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    await initUserDB();
    final user = userBox!.get(widget.userDetails.id);
    if (user != null) {
      currentUserNotifier.value = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ValueListenableBuilder<UserModel?>(
      valueListenable: currentUserNotifier,
      builder: (context, value, _) {
        if (value == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: inside,
                expandedHeight: 250.0,
                pinned: true,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lock_person, color: whiteColor),
                          const SizedBox(width: 8),
                          Text(
                            value.username,
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
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircleAvatar(
                                  backgroundColor: transParent,
                                  child: ClipOval(
                                    child: value.imagePath != null &&
                                            value.imagePath!.isNotEmpty
                                        ? (kIsWeb
                                            ? Image.memory(
                                                base64Decode(value.imagePath!),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              )
                                            : Image.file(
                                                File(value.imagePath!),
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: double.infinity,
                                              ))
                                        : Image.asset(
                                            'assets/welcome/main image.jpg',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10.0,
                          sigmaY: 10.0,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 126, 126, 126)
                                .withOpacity(0.66),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.05,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.cake,
                                        color: textColor2,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        value.age.toString(),
                                        style: TextStyle(color: textColor2),
                                      ),
                                    ],
                                  ),
                                ),
                                BlurredContainer(
                                  icon: Icons.person_2,
                                  maintext: 'Account Name',
                                  text: value.username,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.business_outlined,
                                  maintext: 'Venture Name',
                                  text: value.name,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.phone,
                                  maintext: 'Phone Number',
                                  text: value.phone,
                                  height: screenHeight * 0.068,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                BlurredContainer(
                                  icon: Icons.notes_sharp,
                                  maintext: 'Bio',
                                  text: value.bio,
                                  height: 100,
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                InkWellButton(
                                  onPressed: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                        userdata: value,
                                      ),
                                    ));
                                  },
                                  buttomColor:
                                      const Color.fromARGB(255, 228, 228, 228),
                                  text: 'Edit Profile',
                                  textColor:
                                      const Color.fromARGB(255, 47, 47, 47),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: ListSettingsContier(
                        screenHeight: screenHeight,
                        screenWidth: screenHeight,
                        username: widget.userDetails.id,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
