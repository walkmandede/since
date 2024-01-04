import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/costants/app_constants.dart';
import 'package:since/moduels/since_home/c_since_controller.dart';
import 'package:get/get.dart';

class HomeLoadingShimmerWidget extends StatelessWidget {
  const HomeLoadingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SinceController controller = Get.find();
    return ListView.builder(
      itemCount: 3,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          loop: 0,
          baseColor: Colors.black.withOpacity(0.2),
          highlightColor: Colors.black.withOpacity(0.1),
          child: AspectRatio(
            aspectRatio: controller.eachCardAspectRatio,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              height: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.bgGrey,
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        );
      },
    );
  }
}
