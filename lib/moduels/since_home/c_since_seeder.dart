
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:since/costants/sp_keys.dart';
import 'package:since/moduels/since_home/m_since_model.dart';

class SinceSeeder{

  final List<SinceModel> _sinceSeeds = [
    SinceModel(
        title: 'Smoking',
        records: [
          DateTime(2024,1,1),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
    SinceModel(
        title: 'Being Born',
        records: [
          DateTime(1997,2,19),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
    SinceModel(
        title: 'Breakfast',
        records: [
          DateTime.now().copyWith(hour: 6),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
    SinceModel(
        title: 'Hee hee',
        records: [
          DateTime(2021,11,15),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
    SinceModel(
        title: 'Taking Pot',
        records: [
          DateTime(2024,1,1),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
    SinceModel(
        title: 'Coffee',
        records: [
          DateTime(2024,1,1),
          DateTime(2024,1,2,15,30),
          DateTime(2024,1,3,8,30),
        ],
        subTitle: '',
        sinceTypeEnum: SinceTypeEnum.stop
    ),
  ];

  Future<void> seedSince() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();

    List<String> rawSinceList = _sinceSeeds.map((e) => e.toJson()).toList();

    await sharedPreferences.setStringList(SpKeys.sinceListKey, rawSinceList);
  }


}