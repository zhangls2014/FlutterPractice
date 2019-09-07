// 实况天气
class NowModel {
  // 相对湿度
  String hum;

  // 能见度，默认单位：公里
  String vis;

  // 大气压强
  String pres;

  // 降水量
  String pcpn;

  // 体感温度，默认单位：摄氏度
  String fl;

  // 风力
  String windSc;

  // 风向
  String windDir;

  // 风速，公里/小时
  String windSpd;

  // 云量
  String cloud;

  // 风向360角度
  String windDeg;

  // 体感温度，默认单位：摄氏度
  String tmp;

  // 实况天气状况描述
  String condTxt;

  // 实况天气状况代码
  String condCode;

  NowModel(
      {this.hum,
      this.vis,
      this.pres,
      this.pcpn,
      this.fl,
      this.windSc,
      this.windDir,
      this.windSpd,
      this.cloud,
      this.windDeg,
      this.tmp,
      this.condTxt,
      this.condCode});

  factory NowModel.fromJson(Map<String, dynamic> parsedJson) {
    return NowModel(
        hum: parsedJson['hum'],
        vis: parsedJson['vis'],
        pres: parsedJson['pres'],
        pcpn: parsedJson['pcpn'],
        fl: parsedJson['fl'],
        windSc: parsedJson['wind_sc'],
        windDir: parsedJson['wind_dir'],
        windSpd: parsedJson['wind_spd'],
        cloud: parsedJson['cloud'],
        windDeg: parsedJson['wind_deg'],
        tmp: parsedJson['tmp'],
        condTxt: parsedJson['cond_txt'],
        condCode: parsedJson['cond_code']);
  }
}