import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/event.dart';
import 'package:practice/weather/http/result_model.dart';
import 'package:practice/weather/http/wather_api.dart';
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
  StreamSubscription _refreshSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _refreshSubscription = EventBusManager.instance.eventBus.on<_RefreshEvent>().listen((event) {
      getWeather(event.weatherType);
    });

    getWeather(WeatherType.now);
  }

  void getWeather(WeatherType type) async {
    var api = new WeatherApi();
    ResultModel resultModel = await api.getWeather(type, "成都");
    if (resultModel.success) {
      EventBusManager.instance.eventBus.fire(_WeatherEvent(resultModel.data.heWeather6[0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('天气预报'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: '实况天气'),
                  Tab(text: '天气预报'),
                  Tab(text: '逐小时预报'),
                  Tab(text: '生活指数'),
                  Tab(text: '生活指数预报')
                ],
                isScrollable: true,
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            new WeatherItemWidget(WeatherType.now),
            new WeatherItemWidget(WeatherType.forecast),
            new WeatherItemWidget(WeatherType.hourly),
            new WeatherItemWidget(WeatherType.lifestyle),
            new WeatherItemWidget(WeatherType.lifestyle)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshSubscription.cancel();
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 第一次加载页面，刷新数据
    _doRefresh();
    // 订阅 Event 事件
    _weatherSubscription = EventBusManager.instance.eventBus.on<_WeatherEvent>().listen((event) {
      // 收到新的数据，刷新界面
      switch (widget._weatherType) {
        case WeatherType.now:
          setState(() {
            _nowModel = event.weather.now;
          });
          break;
        case WeatherType.forecast:
          break;
        case WeatherType.hourly:
          break;
        case WeatherType.lifestyle:
          break;
      }
    });
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
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) => getListItem(index),
        itemCount: getItemCount(),
      ),
    );
  }

  // 发送刷新通知，等待返回结果
  Future<void> _doRefresh() async {
    EventBusManager.instance.eventBus.fire(_RefreshEvent(widget._weatherType));
  }

  ListTile getListItem(int index) {
    ListTile item;
    switch (widget._weatherType) {
      case WeatherType.now:
        item = getNowItem(index);
        break;
      case WeatherType.forecast:
        item = getNowItem(index);
        break;
      case WeatherType.hourly:
        item = getNowItem(index);
        break;
      case WeatherType.lifestyle:
        item = getNowItem(index);
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

  int getItemCount() {
    int itemCount;
    switch (widget._weatherType) {
      case WeatherType.now:
        itemCount = 13;
        break;
      case WeatherType.forecast:
        itemCount = 0;
        break;
      case WeatherType.hourly:
        itemCount = 0;
        break;
      case WeatherType.lifestyle:
        itemCount = 0;
        break;
    }

    return itemCount;
  }
}

// 刷新通知
class _RefreshEvent {
  final WeatherType weatherType;

  _RefreshEvent(this.weatherType);
}

// 获取数据
class _WeatherEvent {
  final HeWeather6 weather;

  _WeatherEvent(this.weather);
}
