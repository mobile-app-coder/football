import 'package:flutter/material.dart';
import 'package:football/presentation/home/controllers/setting_page_controller.dart';
import 'package:football/presentation/widgets/custom_diolog.dart';
import 'package:football/presentation/widgets/custom_home_menu_item.dart';
import 'package:football/utils/constants/constants.dart';
import 'package:football/utils/constants/styles.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = Get.find<SettingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sozlamalar",
          style: CustomStyles.pageTitle,
        ),
        actions: [
          GestureDetector(
            child: SizedBox(
                height: 40,
                child: Image.asset("assets/images/settings/logout_img.png")),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        title: "Tizimdan chiqish",
                        content:
                            "Siz tizimdan chiqarib yuborilasiz, sining malumotlaringiz ushu qurilmadan o'chirilib yuboriladi!",
                        button1Text: "Ha",
                        button2Text: "Yoq",
                        button1Function: () {
                          controller.logOut(context);
                        },
                        button2Function: () {
                          Navigator.pop(context);
                        });
                  });
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            6,
            (index) => CustomHomeMenuItem(data: settingMenuItems[index]),
          ),
        ),
      ),
    );
  }
}
