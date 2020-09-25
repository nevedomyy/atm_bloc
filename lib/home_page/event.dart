abstract class HomePageEvent{}

class GetMoneyEvent extends HomePageEvent{
  final int _sum;
  GetMoneyEvent(this._sum);
  int get sum => _sum;
}