
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_super_scaffold/flutter_super_scaffold.dart';
import 'package:get/get.dart';
import 'package:since/costants/app_assets.dart';

enum SinceTypeEnum{
  stop,
  start,
}

enum SinceTierEnum{
  day,
  week,
  month,
  year,
  decade,
  century,
}

class SinceModel{

  String title;
  String subTitle;
  SinceTypeEnum sinceTypeEnum;
  List<DateTime> records;

  SinceModel({
    required this.title,
    required this.records,
    required this.subTitle,
    required this.sinceTypeEnum,
  });

  factory SinceModel.fromMap({required Map<String,dynamic> data}){
    SinceTypeEnum sinceTypeEnum = SinceTypeEnum.stop;

    try{
      sinceTypeEnum = SinceTypeEnum.values.where((element) => element.name==data['sinceTypeEnum'].toString()).first;
    }
    catch(e){
      null;
    }

    Iterable rawRecordsList = data['records']??[];
    List<DateTime> records = [];

    for(final each in rawRecordsList){
      records.add(DateTime.tryParse(data[each.toString()].toString())??DateTime(0));
    }

    return SinceModel(
      title: data['title'].toString(),
      subTitle: data['subTitle'].toString(),
      records: records,
      sinceTypeEnum: sinceTypeEnum,
    );
  }

  factory SinceModel.fromJson({required String json}){
    Map<String,dynamic> data = jsonDecode(json);
    SinceTypeEnum sinceTypeEnum = SinceTypeEnum.stop;

    try{
      sinceTypeEnum = SinceTypeEnum.values.where((element) => element.name==data['sinceTypeEnum'].toString()).first;
    }
    catch(e){
      null;
    }

    Iterable rawRecordsList = data['records']??[];
    List<DateTime> records = [];

    for(final each in rawRecordsList){
      records.add(DateTime.tryParse(each)??DateTime(0));
    }


    return SinceModel(
      title: data['title'].toString(),
      subTitle: data['subTitle'].toString(),
      records: records,
      sinceTypeEnum: sinceTypeEnum,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "title" : title,
      "subTitle" : subTitle,
      "records" : records.map((e) => e.toString()).toList(),
      "sinceTypeEnum" : sinceTypeEnum.name,
    };
  }

  String toJson(){
    return jsonEncode({
      "title" : title,
      "subTitle" : subTitle,
      "records" : records.map((e) => e.toString()).toList(),
      "sinceTypeEnum" : sinceTypeEnum.name,
    });
  }

  void addRecord({required DateTime dateTime}){
    records.add(dateTime);
  }

  DateTime getLastSince(){
    List<DateTime> tempRecords = [];
    tempRecords.addAll(records);
    tempRecords.sort(
          (a, b) {
        //latestDayFirstIndex
        return b.compareTo(a);
      },
    );
    return tempRecords.first;
  }

  Duration getDurationSinceLastTime(){

    Duration duration = DateTime.now().difference(getLastSince());

    return duration;
  }

  SinceTierEnum getCurrentTier(){

    var result = SinceTierEnum.day;

    try{
      final durationSinceLastTime = getDurationSinceLastTime();

      if(durationSinceLastTime.inDays<1){
        //nextGoalIsDay
        result = SinceTierEnum.day;
      }
      else if(durationSinceLastTime.inDays<7){
        //nextGoalIsWeek
        result = SinceTierEnum.week;
      }
      else{
        //nextGoalIsMonth
        final lastSince = getLastSince();
        final oneMonthAfterLastSince = lastSince.copyWith(month: lastSince.month+1);
        final oneYearAfterLastSince = lastSince.copyWith(year: lastSince.year+1);
        final tenYearAfterLastSince = lastSince.copyWith(year: lastSince.year+10);
        final now = DateTime.now();

        if(now.isBefore(oneMonthAfterLastSince)){
          //nextGoalIsMonth
          result = SinceTierEnum.month;
        }
        else{
          if(now.isBefore(oneYearAfterLastSince)){
            //nextGoalIsYear
            result = SinceTierEnum.year;
          }
          else{
            if(now.isBefore(tenYearAfterLastSince)){
              //nextGoalIsDecade
              result = SinceTierEnum.decade;
            }
            else{
              result = SinceTierEnum.century;
            }
          }
        }
      }

    }
    catch(e){
      null;
    }

    return result;
  }

  Duration getDurationToNextGoal(){

    final lastSince = getLastSince();
    final oneDayAfterLastSince = lastSince.add(const Duration(days: 1));
    final oneWeekAfterLastSince = lastSince.add(const Duration(days: 7));
    final oneMonthAfterLastSince = lastSince.copyWith(month: lastSince.month+1);
    final oneYearAfterLastSince = lastSince.copyWith(year: lastSince.year+1);
    final tenYearAfterLastSince = lastSince.copyWith(year: lastSince.year+10);
    final hundredYearAfterLastSince = lastSince.copyWith(year: lastSince.year+100);

    switch(getCurrentTier()){
      case SinceTierEnum.day : return oneDayAfterLastSince.difference(lastSince);
      case SinceTierEnum.week : return oneWeekAfterLastSince.difference(lastSince);
      case SinceTierEnum.month : return oneMonthAfterLastSince.difference(lastSince);
      case SinceTierEnum.year : return oneYearAfterLastSince.difference(lastSince);
      case SinceTierEnum.decade : return tenYearAfterLastSince.difference(lastSince);
      case SinceTierEnum.century : return hundredYearAfterLastSince.difference(lastSince);
    }
  }

  DateTime getNextGoalDateTime(){

    final lastSince = getLastSince();

    switch(getCurrentTier()){
      case SinceTierEnum.day : return lastSince.add(const Duration(days: 1));
      case SinceTierEnum.week : return lastSince.add(const Duration(days: 7));
      case SinceTierEnum.month : return lastSince.copyWith(month: lastSince.month+1);
      case SinceTierEnum.year : return lastSince.copyWith(year: lastSince.year+1);
      case SinceTierEnum.decade : return lastSince.copyWith(year: lastSince.year+10);
      case SinceTierEnum.century : return lastSince.copyWith(year: lastSince.year+100);
    }
  }

  String getTierBadge(){
    switch(getCurrentTier()){
      case SinceTierEnum.day : return AppAssets.dayBadge;
      case SinceTierEnum.week : return AppAssets.weekBadge;
      case SinceTierEnum.month : return AppAssets.monthBadge;
      case SinceTierEnum.year : return AppAssets.yearBadge;
      case SinceTierEnum.decade : return AppAssets.decadeBadge;
      case SinceTierEnum.century : return AppAssets.centuryBadge;
    }
  }

  Color getTierColor(){
    switch(getCurrentTier()){
      case SinceTierEnum.day : return Colors.brown;
      case SinceTierEnum.week : return Colors.white;
      case SinceTierEnum.month : return Colors.amberAccent;
      case SinceTierEnum.year : return Colors.orangeAccent;
      case SinceTierEnum.decade : return Colors.purpleAccent;
      case SinceTierEnum.century : return Colors.cyanAccent;
    }
  }

}