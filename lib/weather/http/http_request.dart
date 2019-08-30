import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:practice/weather/http/config.dart';
import 'package:practice/weather/http/result_code.dart';
import 'package:practice/weather/http/result_error_event.dart';
import 'package:practice/weather/http/result_model.dart';
import 'package:practice/weather/model/weather_model.dart';

class HttpRequest {
  static const String REQUEST_KEY = "1b164d13d50b41bd8a15be018e1dd16e";

  Dio _dio;
  static Map<String, String> baseHeaders = {
//    "packageName":"com.puxin.financePlanner",
//    "appName":"",
//    "version":"1.8.7.3",
//    "os":"ios",
//    "channel":"appStore",
//    "platform":"11.1999998092651",
//    "model":"",
//    "factory":"apple",
//    "screenSize":"(0.0, 0.0, 375.0, 667.0)",
//    "clientId":"15444",
//    "token":"7fc30ec2206ec3135ca9d33d11406b36b048e4950836a678c4642e492",
//    "sign":"",
//    "pid":"pid",
//    "registrationId":"pid",
  };
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static const Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  // 工厂模式
  factory HttpRequest() => _getInstance();

  static HttpRequest get instance => _getInstance();
  static HttpRequest _instance;

  static HttpRequest _getInstance() {
    if (_instance == null) {
      _instance = new HttpRequest._internal();
    }
    return _instance;
  }

  HttpRequest._internal() {
    _dio = new Dio();
    if (Config.DEBUG) {
      _dio.interceptors.add(LogInterceptor(
          request: false, requestHeader: false, requestBody: true, responseHeader: false, responseBody: true));
    }
    _dio.options
      ..baseUrl = "https://free-api.heweather.net/s6/"
      ..headers = baseHeaders
      ..connectTimeout = 15000
      ..receiveTimeout = 15000;
  }

  Future<ResultModel> requestPost(url, params, {noTip = false}) async {
    Options option = new Options(method: 'post');
    return await _requestBase(url, params, option, noTip: noTip);
  }

  Future<ResultModel> requestGet(url, params, {noTip = false}) async {
    Options option = new Options(method: "get");
    return await _requestBase(url, params, option, noTip: noTip);
  }

  _requestBase(url, params, Options option, {noTip = false}) async {
    // 判断网络
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // TODO 在下载文件的时候可以做一些提醒
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //
    } else if (connectivityResult == ConnectivityResult.none) {
      return ResultModel(ResultErrorEvent(ResultCode.NETWORK_ERROR, "请检查网络"), false, ResultCode.NETWORK_ERROR);
    }

    try {
      Response response = await _dio.request(url, queryParameters: params, data: params, options: option);
      var weatherModel = WeatherModel.fromJson(response.data);
      return new ResultModel(weatherModel, true, ResultCode.SUCCESS, headers: response.headers);
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
        // TODO 在这里可以对错误信息进行解析
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 超时
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = ResultCode.NETWORK_TIMEOUT;
      }
      // 返回错误信息
      return new ResultModel(ResultCode.errorHandleFunction(errorResponse.statusCode, error.message, noTip), false,
          errorResponse.statusCode);
    }
  }
}
