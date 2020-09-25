import 'dart:async';

import 'package:atm/home_page/event.dart';
import 'package:atm/home_page/model/result.dart';

class HomePageBloc{
  final StreamController _stateController = StreamController<Result>();
  final StreamController _eventController = StreamController<HomePageEvent>();
  List<int> _limits = [100, 200, 500, 1000, 2000, 5000];
  List<int> _balance = [50, 50, 50, 50, 50, 50];

  HomePageBloc(){
    _stateController.sink.add(Result(null, _balance));
    _eventController.stream.listen((event) {_events(event);});
  }

  _events(HomePageEvent event){
    if(event is GetMoneyEvent) {
      getMoney(event.sum);
    }
    return event;
  }

  getMoney(int sum){
    if(sum == 0){
      _stateController.sink.add(Result([], _balance));
      return;
    }
    List<int> tmpBalance = List.from(_balance);
    List<int> give = List.generate(6, (_) => 0);
    for (int loop=0; loop<40; loop++){// 40 купюр лимит
      for (int nominal=5; nominal>=0; nominal--){
        if(sum >=_limits[nominal] && tmpBalance[nominal] > 0){
          sum -= _limits[nominal];
          tmpBalance[nominal]--;
          give[nominal]++;
          break;
        }
      }
      if(sum == 0){
        _balance = List.from(tmpBalance);
        break;
      }
      if(sum < _limits[0]){
        give = [];
        break;
      }
      if(loop == 39) give = [];
    }
    _stateController.sink.add(Result(give, _balance));
  }

  Stream<Result> get stream => _stateController.stream;
  StreamSink<HomePageEvent> get event => _eventController.sink;

  dispose(){
    _stateController.close();
    _eventController.close();
  }
}