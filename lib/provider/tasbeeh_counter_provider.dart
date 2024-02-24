import 'package:flutter/foundation.dart';

class TasbeehCounterProvider extends ChangeNotifier{
  int _count = 0;
  int get count => _count;

  void addCount()
  {
    _count++;
    notifyListeners();
  }

  void setCount(int value)
  {
    _count =value;
    notifyListeners();
  }

  void resetCount()
  {
    _count = 0;
    notifyListeners();
  }

}