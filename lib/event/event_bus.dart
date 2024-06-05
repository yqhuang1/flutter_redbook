import 'package:event_bus_plus/res/event_bus.dart';

EventBus eventBus = EventBus();

class OpenDrawerEvent{
  String unit;
  OpenDrawerEvent(this.unit);
}