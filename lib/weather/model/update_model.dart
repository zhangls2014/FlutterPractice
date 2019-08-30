// 接口更新时间
class UpdateModel {
  // 当地时间
  String loc;

  // UTC 时间
  String utc;

  UpdateModel({this.loc, this.utc});

  factory UpdateModel.fromJson(Map<String, dynamic> parsedJson) {
    return UpdateModel(loc: parsedJson['loc'], utc: parsedJson['utc']);
  }
}
