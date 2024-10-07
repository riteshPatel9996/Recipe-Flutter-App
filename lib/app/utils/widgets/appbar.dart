

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipes_flutter/app/config/Theme/app_theme.dart';

class AppBarWidget extends StatefulWidget {
  final title;
  List<Widget>? actions = [];

  AppBarWidget({super.key, @required this.title, this.actions});

  @override
  AppBarWidgetState createState() => AppBarWidgetState();
}

class AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Color(0xffFFFAFA),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      titleSpacing: 0,
      backgroundColor: AppTheme.appConstColor,
      elevation: 0,
      actions: widget.actions,
      title: widget.title,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
          ),
          onPressed: () {
           Get.back();
          },
        ),
      ),
    );
  }
}
