import 'package:practice/weather/model/basic_model.dart';
import 'package:practice/weather/model/daily_forecast_model.dart';
import 'package:practice/weather/model/lifestyle_model.dart';
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
  List<DailyForecastModel> dailyForecast;
  List<LifestyleModel> lifestyle;

  HeWeather6({this.status, this.update, this.basic, this.now, this.dailyForecast, this.lifestyle});

  factory HeWeather6.fromJson(Map<String, dynamic> parsedJson) {
    var now;
    if (parsedJson['now'] == null) {
      now = null;
    } else {
      now = NowModel.fromJson(parsedJson['now']);
    }
    var dailyForecastList = (parsedJson['daily_forecast'] as List)
        ?.map((i) => DailyForecastModel.fromJson(i))
        ?.toList();
    var lifestyleList = (parsedJson['lifestyle'] as List)?.map((i) => LifestyleModel.fromJson(i))?.toList();
    return HeWeather6(
        status: parsedJson['status'],
        update: UpdateModel.fromJson(parsedJson['update']),
        basic: BasicModel.fromJson(parsedJson['basic']),
        now: now,
        dailyForecast: dailyForecastList,
        lifestyle: lifestyleList);
  }
}
