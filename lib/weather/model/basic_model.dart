// 基础信息
class BasicModel {
  // 该地区／城市所属行政区域
  String adminArea;

  // 该地区／城市所在时区
  String tz;

  // 地区／城市名称
  String location;

  // 地区／城市经度
  String lon;

  // 该地区／城市的上级城市
  String parentCity;
  String cnty;

  // 地区／城市纬度
  String lat;

  // 地区／城市ID
  String cid;

  BasicModel({this.adminArea, this.tz, this.location, this.lon, this.parentCity, this.cnty, this.lat, this.cid});

  factory BasicModel.fromJson(Map<String, dynamic> parsedJson) {
    return BasicModel(
        adminArea: parsedJson['admin_area'],
        tz: parsedJson['tz'],
        location: parsedJson['location'],
        lon: parsedJson['lon'],
        parentCity: parsedJson['parent_city'],
        cnty: parsedJson['cnty'],
        lat: parsedJson['lat'],
        cid: parsedJson['cid']);
  }
}
