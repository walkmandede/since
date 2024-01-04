import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/costants/app_constants.dart';
import 'package:since/moduels/since_home/c_since_controller.dart';
import 'package:get/get.dart';
import 'package:since/moduels/since_home/widgets/w_home_app_bar.dart';
import 'package:since/moduels/since_home/widgets/w_home_data_view.dart';
import 'package:since/service/sizedbox_extension.dart';
import 'package:since/service/vibrate_service.dart';
import 'package:tabler_icons/tabler_icons.dart';

class SinceHomePage extends StatelessWidget {
  const SinceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SinceController());
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          vibrateNow();
        },
        backgroundColor: AppColors.bgGrey,
        label: Text('Add New Since',style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(AppConstants.basePadding),
        child: Column(
          children: [
            (Get.mediaQuery.padding.top).heightBox(),
            const HomeAppBar(),
            (Get.height * 0.025).heightBox(),
            const Expanded(
              child: HomeDataView(),
            ),
          ],
        ),
      ),
    );
  }




}
