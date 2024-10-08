import 'package:flutter/material.dart';
import 'package:football/presentation/home/pages/settings_pages/controllers/profile_page_controller.dart';
import 'package:football/presentation/widgets/custom_button.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final controller = Get.find<ProfilePageController>();

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ProfilePageController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfilePageController>(builder: (_) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "Profil",
            style: CustomStyles.pageTitle,
          ),
        ),
        body: Padding(
          padding: EdgeInsetsDirectional.zero,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: controller.profileImage != null
                                ? Image.network(
                                    controller.profileImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.orange,
                          ),
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              controller.chooseImage();
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.name != null ? controller.name! : "",
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.nameCont,
                    decoration: InputDecoration(
                        hintText: "Nickname o’zgartirish",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.1))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: controller.phoneNumberCont,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [controller.phoneNumberMask],
                    decoration: InputDecoration(
                        hintText: "Raqamni o’zgartirish",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 0.1))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.passwordCont,
                            obscureText: controller.showPassword,
                            decoration: const InputDecoration(
                                hintText: "Parolni o’zgartirish",
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          alignment: Alignment.center,
                          onPressed: () {
                            controller.hidePassword();
                          },
                          icon: controller.showPassword
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(text: "Saqlash", onPress: () {
                    controller.updateUserData();
                  })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
