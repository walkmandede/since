import 'package:flutter/material.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/service/vibrate_service.dart';
import 'package:tabler_icons/tabler_icons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            vibrateNow();
          },
          icon: Icon(TablerIcons.menu,color: AppColors.white,),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            vibrateNow();
          },
          icon: Icon(TablerIcons.search,color: AppColors.white,),
        ),
        IconButton(
          onPressed: () {
            vibrateNow();
          },
          icon: Icon(TablerIcons.notification,color: AppColors.white,),
        ),
      ],
    );
  }
}
