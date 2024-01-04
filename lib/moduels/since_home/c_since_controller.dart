
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:since/costants/sp_keys.dart';
import 'package:since/moduels/since_home/c_since_seeder.dart';
import 'package:since/moduels/since_home/m_since_model.dart';

class SinceController extends GetxController{

  ValueNotifier<bool> xLoaded = ValueNotifier<bool>(false);
  ValueNotifier<List<SinceModel>> allSinceData = ValueNotifier<List<SinceModel>>([]);

  double eachCardAspectRatio = 16/7;


  @override
  void onInit() {
    initLoad();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<void> initLoad() async{
    try{
      //removeThisCodeIfYouDoNotWantSeeding
      await SinceSeeder().seedSince();

      //gettingDataFromStorage
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final rawList = sharedPreferences.getStringList(SpKeys.sinceListKey)??[];
      //listenMainThreadDataToSyncWithStorageData
      allSinceData.addListener(() {
        sharedPreferences.setStringList(SpKeys.sinceListKey, allSinceData.value.map((e) => e.toJson()).toList());
      });


      allSinceData.value.addAll(rawList.map((e) => SinceModel.fromJson(json: e)).toList());
      allSinceData.notifyListeners();

    }
    catch(e){
      null;
    }
    await Future.delayed(const Duration(seconds: 4));
    xLoaded.value = true;
    xLoaded.notifyListeners();
  }

}