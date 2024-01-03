
enum SinceTypeEnum{
  stop,
  start,
}

class SinceModel{

  DateTime since;
  String title;
  String subTitle;
  SinceTypeEnum sinceTypeEnum;

  SinceModel({
    required this.title,
    required this.since,
    required this.subTitle,
    required this.sinceTypeEnum
  });

  factory SinceModel.fromMap({required Map<String,dynamic> data}){


    SinceTypeEnum sinceTypeEnum = SinceTypeEnum.stop;

    try{
      sinceTypeEnum = SinceTypeEnum.values.where((element) => element.name==data['sinceTypeEnum'].toString()).first;
    }
    catch(e){
      null;
    }

    return SinceModel(
      title: data['title'].toString(),
      subTitle: data['subTitle'].toString(),
      since: DateTime.tryParse(data['since'].toString())??DateTime(0),
      sinceTypeEnum: sinceTypeEnum,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "title" : title,
      "subTitle" : subTitle,
      "since" : since.toString(),
      "sinceTypeEnum" : sinceTypeEnum.name,
    };
  }

}