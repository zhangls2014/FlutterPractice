class DailyForecastModel {
  // 预报日期
  String date;

  // 日落时间
  String ss;

  // 最低温度
  String tmpMin;

  // 相对湿度
  String hum;

  // 能见度，单位：公里
  String vis;

  // 白天天气状况描述
  String condTxtD;

  // 大气压强
  String pres;

  // 月升时间
  String mr;

  // 降水量
  String pcpn;

  // 月落时间
  String ms;

  // 夜间天气状况代码
  String condCodeN;

  // 风力
  String windSc;

  // 风向
  String windDir;

  // 风速，公里/小时
  String windSpd;

  // 降水概率
  String pop;

  // 风向360角度
  String windDeg;

  // 紫外线强度指数
  String uvIndex;

  // 最高温度
  String tmpMax;

  // 晚间天气状况描述
  String condTxtN;

  // 白天天气状况代码
  String condCodeD;

  // 日出时间
  String sr;

  DailyForecastModel(
      {this.date,
      this.ss,
      this.tmpMin,
      this.hum,
      this.vis,
      this.condTxtD,
      this.pres,
      this.mr,
      this.pcpn,
      this.ms,
      this.condCodeN,
      this.windSc,
      this.windDir,
      this.windSpd,
      this.pop,
      this.windDeg,
      this.uvIndex,
      this.tmpMax,
      this.condTxtN,
      this.condCodeD,
      this.sr});

  factory DailyForecastModel.fromJson(Map<String, dynamic> parsedJson) {
    return DailyForecastModel(
        date: parsedJson['date'],
        ss: parsedJson['ss'],
        tmpMin: parsedJson['tmp_min'],
        hum: parsedJson['hum'],
        vis: parsedJson['vis'],
        condTxtD: parsedJson['cond_txt_d'],
        pres: parsedJson['pres'],
        mr: parsedJson['mr'],
        pcpn: parsedJson['pcpn'],
        ms: parsedJson['ms'],
        condCodeN: parsedJson['cond_code_n'],
        windSc: parsedJson['wind_sc'],
        windDir: parsedJson['wind_dir'],
        windSpd: parsedJson['wind_spd'],
        pop: parsedJson['pop'],
        windDeg: parsedJson['wind_deg'],
        uvIndex: parsedJson['uv_index'],
        tmpMax: parsedJson['tmp_max'],
        condTxtN: parsedJson['cond_txt_n'],
        condCodeD: parsedJson['cond_code_d'],
        sr: parsedJson['sr']);
  }
}
