class ResultModel {
  bool success;
  int code;
  var headers;
  var data;

  ResultModel(this.data, this.success, this.code, {this.headers});
}
