import 'package:practice/weather/http/http_request.dart';
import 'package:practice/weather/http/result_model.dart';

class WeatherApi {
  // 接口请求参数
  static const Map<WeatherType, String> _weatherTypeMap = {
    WeatherType.now: 'now',
    WeatherType.forecast: 'forecast',
    WeatherType.hourly: 'hourly',
    WeatherType.lifestyle: 'lifestyle'
  };

  // 获取天气预报
  Future<ResultModel> getWeather(WeatherType weatherType, String location) async {
    var data = {"location": location, "lang": "zh", "key": HttpRequest.REQUEST_KEY};

    return await HttpRequest.instance.requestGet('weather/${_weatherTypeMap[weatherType]}', data);
  }
}

// 接口请求参数
enum WeatherType {
  // 实况天气
  now,
  // 3-10天预报
  forecast,
  // 逐小时预报
  hourly,
  // 生活指数
  lifestyle
}
