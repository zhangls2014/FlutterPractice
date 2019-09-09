import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practice/event.dart';
import 'package:practice/weather/event/daily_forecast_event.dart';
import 'package:practice/weather/event/lifestyle_event.dart';
import 'package:practice/weather/event/now_event.dart';
import 'package:practice/weather/http/result_model.dart';
import 'package:practice/weather/http/wather_api.dart';
import 'package:practice/weather/model/daily_forecast_model.dart';
import 'package:practice/weather/model/lifestyle_model.dart';
import 'package:practice/weather/model/now_model.dart';
import 'package:practice/weather/model/weather_model.dart';

class PageWeatherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageWeatherState();
  }
}

class PageWeatherState extends State<PageWeatherWidget> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('天气预报'),
              pinned: true,
              bottom: TabBar(
                tabs: <Widget>[Tab(text: '实况天气'), Tab(text: '天气预报'), Tab(text: '生活指数')],
                isScrollable: true,
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            WeatherItemWidget(WeatherType.now),
            WeatherItemWidget(WeatherType.forecast),
            WeatherItemWidget(WeatherType.lifestyle)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class WeatherItemWidget extends StatefulWidget {
  final WeatherType _weatherType;

  WeatherItemWidget(this._weatherType);

  @override
  State<StatefulWidget> createState() {
    return WeatherItemState();
  }
}

class WeatherItemState extends State<WeatherItemWidget> with AutomaticKeepAliveClientMixin {
  StreamSubscription _weatherSubscription;
  NowModel _nowModel;
  List<DailyForecastModel> _dailyForecastModel;
  List<LifestyleModel> _lifestyleModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 第一次加载页面，刷新数据
    _doRefresh();
    // 订阅 Event 事件
    switch (widget._weatherType) {
      case WeatherType.now:
        _weatherSubscription = EventBusManager.instance.eventBus.on<NowEvent>().listen((event) {
          // 收到新的数据，刷新界面
          setState(() {
            _nowModel = event.now;
          });
        });
        break;
      case WeatherType.forecast:
        _weatherSubscription = EventBusManager.instance.eventBus.on<DailyForecastEvent>().listen((event) {
          // 收到新的数据，刷新界面
          setState(() {
            _dailyForecastModel = event.dailyForecast;
          });
        });
        break;
      case WeatherType.hourly:
        break;
      case WeatherType.lifestyle:
        _weatherSubscription = EventBusManager.instance.eventBus.on<LifestyleEvent>().listen((event) {
          // 收到新的数据，刷新界面
          setState(() {
            _lifestyleModel = event.lifestyle;
          });
        });
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _weatherSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _doRefresh,
      child: ListView.separated(
        padding: EdgeInsets.only(top: 0),
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
        itemBuilder: (BuildContext context, int index) => getListItem(index),
        itemCount: getItemCount(),
      ),
    );
  }

  // 发送刷新通知，等待返回结果
  Future<void> _doRefresh() async {
    return Future(() async {
      var api = new WeatherApi();
      ResultModel resultModel = await api.getWeather(widget._weatherType, "成都");
      if (resultModel.success) {
        HeWeather6 model = resultModel.data.heWeather6[0];
        switch (widget._weatherType) {
          case WeatherType.now:
            EventBusManager.instance.eventBus.fire(NowEvent(model.now));
            break;
          case WeatherType.forecast:
            EventBusManager.instance.eventBus.fire(DailyForecastEvent(model.dailyForecast));
            break;
          case WeatherType.hourly:
            break;
          case WeatherType.lifestyle:
            EventBusManager.instance.eventBus.fire(LifestyleEvent(model.lifestyle));
            break;
        }
      }
    });
  }

  Widget getListItem(int index) {
    Widget item;
    switch (widget._weatherType) {
      case WeatherType.now:
        item = getNowItem(index);
        break;
      case WeatherType.forecast:
        item = getDailyForestItem(index);
        break;
      case WeatherType.hourly:
        item = getNowItem(index);
        break;
      case WeatherType.lifestyle:
        item = getLifestyleItem(index);
        break;
    }

    return item;
  }

  ListTile getNowItem(int index) {
    ListTile _listTile;
    switch (index) {
      case 0:
        _listTile = ListTile(title: Text('相对湿度：'), trailing: Text('${_nowModel?.hum ?? 0}'));
        break;
      case 1:
        _listTile = ListTile(title: Text('能见度：'), trailing: Text('${_nowModel?.vis ?? 0}公里'));
        break;
      case 2:
        _listTile = ListTile(title: Text('大气压强：'), trailing: Text('${_nowModel?.pres}'));
        break;
      case 3:
        _listTile = ListTile(title: Text('降水量：'), trailing: Text('${_nowModel?.pcpn}'));
        break;
      case 4:
        _listTile = ListTile(title: Text('体感温度：'), trailing: Text('${_nowModel?.fl ?? 0}摄氏度'));
        break;
      case 5:
        _listTile = ListTile(title: Text('风力：'), trailing: Text('${_nowModel?.windSc}'));
        break;
      case 6:
        _listTile = ListTile(title: Text('风向：'), trailing: Text('${_nowModel?.windDir}'));
        break;
      case 7:
        _listTile = ListTile(title: Text('风速：'), trailing: Text('${_nowModel?.windSpd}公里/小时'));
        break;
      case 8:
        _listTile = ListTile(title: Text('云量：'), trailing: Text('${_nowModel?.cloud}'));
        break;
      case 9:
        _listTile = ListTile(title: Text('风向360角度：'), trailing: Text('${_nowModel?.windDeg}'));
        break;
      case 10:
        _listTile = ListTile(title: Text('体感温度：'), trailing: Text('${_nowModel?.tmp}摄氏度'));
        break;
      case 11:
        _listTile = ListTile(title: Text('实况天气状况描述：'), trailing: Text('${_nowModel?.condTxt}'));
        break;
      case 12:
        _listTile = ListTile(title: Text('实况天气状况代码：'), trailing: Text('${_nowModel?.condCode}'));
        break;
      default:
        _listTile = ListTile(title: Text('实况天气状况代码：'), trailing: Text('${_nowModel?.condCode}'));
    }

    return _listTile;
  }

  Card getDailyForestItem(int index) {
    final model = _dailyForecastModel[index];
    return Card(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 0),
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListTile(title: Text('预报日期：'), trailing: Text('${model?.date ?? 0}')),
          ListTile(title: Text('日落时间：'), trailing: Text('${model?.ss ?? 0}')),
          ListTile(title: Text('日出时间：'), trailing: Text('${model?.sr ?? 0}')),
          ListTile(title: Text('最低温度：'), trailing: Text('${model?.tmpMin}摄氏度')),
          ListTile(title: Text('最高温度：'), trailing: Text('${model?.tmpMax}摄氏度')),
          ListTile(title: Text('相对湿度：'), trailing: Text('${model?.hum ?? 0}')),
          ListTile(title: Text('能见度：'), trailing: Text('${model?.vis}公里')),
          ListTile(title: Text('大气压强：'), trailing: Text('${model?.pres}')),
          ListTile(title: Text('月升时间：'), trailing: Text('${model?.mr}')),
          ListTile(title: Text('月落时间：'), trailing: Text('${model?.ms}')),
          ListTile(title: Text('降水量：'), trailing: Text('${model?.pcpn}')),
          ListTile(title: Text('降水概率：'), trailing: Text('${model?.pop}')),
          ListTile(title: Text('风向：'), trailing: Text('${model?.windDir}')),
          ListTile(title: Text('风力：'), trailing: Text('${model?.windSc}')),
          ListTile(title: Text('风速：'), trailing: Text('${model?.windSpd}公里/小时')),
          ListTile(title: Text('风向360角度：'), trailing: Text('${model?.windDeg}')),
          ListTile(title: Text('紫外线强度指数：'), trailing: Text('${model?.uvIndex}')),
          ListTile(title: Text('白天天气状况描述：'), trailing: Text('${model?.condTxtD}')),
          ListTile(title: Text('白天天气状况代码：'), trailing: Text('${model?.condCodeD}')),
          ListTile(title: Text('晚间天气状况描述：'), trailing: Text('${model?.condTxtN}')),
          ListTile(title: Text('夜间天气状况代码：'), trailing: Text('${model?.condCodeN}'))
        ],
      ),
    );
  }

  Card getLifestyleItem(int index) {
    final model = _lifestyleModel[index];
    return Card(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListTile(
            title: Text('生活指数类型'),
            subtitle: Text(getLifestyleType(model.type)),
          ),
          ListTile(
            title: Text('生活指数简介'),
            subtitle: Text('${model?.brf ?? ''}'),
          ),
          ListTile(
            title: Text('生活指数详细描述'),
            subtitle: Text('${model?.txt ?? ''}'),
          )
        ],
      ),
    );
  }

  String getLifestyleType(String type) {
    String typeText;
    switch (type) {
      case 'comf':
        typeText = '舒适度指数';
        break;
      case 'cw':
        typeText = '洗车指数';
        break;
      case 'drsg':
        typeText = '穿衣指数';
        break;
      case 'flu':
        typeText = '感冒指数';
        break;
      case 'sport':
        typeText = '运动指数';
        break;
      case 'trav':
        typeText = '旅游指数';
        break;
      case 'uv':
        typeText = '紫外线指数';
        break;
      case 'air':
        typeText = '空气污染扩散条件指数';
        break;
      case 'ac':
        typeText = '空调开启指数';
        break;
      case 'ag':
        typeText = '过敏指数';
        break;
      case 'gl':
        typeText = '太阳镜指数';
        break;
      case 'mu':
        typeText = '化妆指数';
        break;
      case 'airc':
        typeText = '晾晒指数';
        break;
      case 'ptfc':
        typeText = '交通指数';
        break;
      case 'fsh':
        typeText = '钓鱼指数';
        break;
      case 'spi':
        typeText = '防晒指数';
        break;
      default:
        typeText = '';
        break;
    }
    return typeText;
  }

  int getItemCount() {
    int itemCount;
    switch (widget._weatherType) {
      case WeatherType.now:
        itemCount = 13;
        break;
      case WeatherType.forecast:
        itemCount = _dailyForecastModel?.length ?? 0;
        break;
      case WeatherType.hourly:
        itemCount = 0;
        break;
      case WeatherType.lifestyle:
        itemCount = _lifestyleModel?.length ?? 0;
        break;
    }

    return itemCount;
  }
}
