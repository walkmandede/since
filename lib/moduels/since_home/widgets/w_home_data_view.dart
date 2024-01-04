import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/costants/app_constants.dart';
import 'package:since/moduels/since_home/c_since_controller.dart';
import 'package:get/get.dart';
import 'package:since/moduels/since_home/m_since_model.dart';
import 'package:since/moduels/since_home/widgets/w_lodaing_shimmer_widget.dart';
import 'package:since/service/sizedbox_extension.dart';
import 'w_home_no_data_yet_widget.dart';

class HomeDataView extends StatelessWidget {
  const HomeDataView({super.key});

  @override
  Widget build(BuildContext context) {
    SinceController controller = Get.find();
    return SizedBox.expand(
      child: ValueListenableBuilder(
        valueListenable: controller.xLoaded,
        builder: (context, value, child) {
          if(!value){
            return const HomeLoadingShimmerWidget();
          }
          else{
            return ValueListenableBuilder(
              valueListenable: controller.allSinceData,
              builder: (context, value, child) {
                if(value.isEmpty){
                  return const HomeNoDataYetWidget();
                }
                else{
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: Get.height * 0.1
                    ),
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      final sinceModel = value[index];
                      return AspectRatio(
                        aspectRatio: controller.eachCardAspectRatio,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            Size maxSize = Size(constraints.maxWidth, constraints.maxHeight);
                            return Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: maxSize.width * 0.05,
                                      vertical: maxSize.width * 0.05
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: AppConstants.basePadding
                                  ),
                                  decoration: BoxDecoration(
                                      color: sinceModel.getTierColor().withOpacity(0.2),
                                      border: Border.all(
                                        color: sinceModel.getTierColor(),
                                        width: 1.5,
                                      ),
                                      // color: AppColors.bgGrey,
                                      borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                "I'd been ${sinceModel.sinceTypeEnum==SinceTypeEnum.stop?"stopped":"started"} ${sinceModel.title} Since",
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: FittedBox(
                                              child: Text(
                                                DateFormat('d MMM, yyyy (EEE)').format(sinceModel.getLastSince()),
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final tier = sinceModel.getCurrentTier();
                                          final durationToNow = sinceModel.getDurationSinceLastTime();
                                          final durationToNext = sinceModel.getDurationToNextGoal();
                                          final baseWidth = maxSize.width * 0.6;
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: baseWidth,
                                                height: maxSize.height * 0.05,
                                                decoration: BoxDecoration(
                                                  color: AppColors.bgBlack,
                                                  borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                                                ),
                                                alignment: Alignment.centerLeft,
                                                child: Container(
                                                  width: baseWidth * (durationToNow.inMinutes/durationToNext.inMinutes),
                                                  height: maxSize.height * 0.05,
                                                  decoration: BoxDecoration(
                                                      color: sinceModel.getTierColor(),
                                                      borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius)
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: maxSize.width * 0.01,
                                  child: Image.asset(
                                    sinceModel.getTierBadge(),
                                    width: maxSize.width * 0.1,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
