import 'package:flutter/material.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/moduels/since/c_since.dart';
import 'package:get/get.dart';

class SinceListPage extends StatelessWidget {
  const SinceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SinceController());
    return Scaffold(
      backgroundColor: AppColors.bgBlack,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        backgroundColor: AppColors.bgGrey,
        label: Text('Add New Since',style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.white),),
      ),
    );
  }
}
