import 'package:event_bus/event_bus.dart';

// EventBus 单例
class EventBusManager {
  // 实例获取方法
  factory EventBusManager() => _getInstance();

  static EventBusManager get instance => _getInstance();

  static EventBusManager _instance;

  static EventBusManager _getInstance() {
    if (_instance == null) {
      _instance = new EventBusManager._internal();
    }
    return _instance;
  }

  EventBus eventBus;

  // 初始化方法
  EventBusManager._internal() {
    eventBus = EventBus();
  }
}
