import 'package:practice/weather/model/basic_model.dart';
import 'package:practice/weather/model/now_model.dart';
import 'package:practice/weather/model/update_model.dart';

class WeatherModel {
  List<HeWeather6> heWeather6;

  WeatherModel({this.heWeather6});

  factory WeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['HeWeather6'] as List;
    var heList = list.map((i) => HeWeather6.fromJson(i)).toList();
    return WeatherModel(heWeather6: heList);
  }
}

class HeWeather6 {
  // 状态
  String status;
  UpdateModel update;
  BasicModel basic;
  NowModel now;

  HeWeather6({this.status, this.update, this.basic, this.now});

  factory HeWeather6.fromJson(Map<String, dynamic> parsedJson) {
    return HeWeather6(
        status: parsedJson['status'],
        update: UpdateModel.fromJson(parsedJson['update']),
        basic: BasicModel.fromJson(parsedJson['basic']),
        now: NowModel.fromJson(parsedJson['now']));
  }
}
