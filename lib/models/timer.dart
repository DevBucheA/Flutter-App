import 'dart:async';
import './timermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  int work = 30;
  double _radius = 1;
  bool _isActive = true;
  late Timer timer;
  late Duration _time;
  late Duration _fullTime;
  int shortBreak = 5;
  int longBreak = 20;

  get percent => percent;

  String get time => time;

  void startBreak(bool isShort){
    _radius = 1;
    _time = Duration(  
      minutes: (isShort) ? shortBreak : longBreak,
      seconds:0
    );
    _fullTime = _time;
  }

  void startWork() async{
    await readSettings();
    _radius = 1;
    _time = Duration(minutes: this.work , seconds: 0);
    _fullTime= _time;
  }

  void StopTimer() {
    this._isActive = false;
  }

  void startTimer(){
    if(_time.inSeconds > 0){
      this._isActive = true;
    }
  }

  String returnTime(Duration t){
  String minutes = (t.inMinutes<10)? '0' + t.inMinutes.toString():t.inMinutes.toString();
  int numSeconds = t.inSeconds - (t.inMinutes * 60);
  String seconds = (numSeconds < 10)? '0' + numSeconds.toString():numSeconds.toString();
  String formattedTime = minutes + ':' + seconds;
  return formattedTime;
}

Stream<TimerModel> stream() async* {
  yield* Stream.periodic(Duration(seconds: 1), (int a){
    String time;
    if(this._isActive){
      _time = _time -  Duration(seconds: 1);
      _radius = _time.inSeconds / _fullTime.inSeconds;
      if(_time.inSeconds <= 0){
        _isActive = false;
      }
    }
    time = returnTime(_time);
    return TimerModel(time, _radius);
  });
}

Future readSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  work = prefs.getInt('workTime') ?? 30;

  shortBreak = prefs.getInt('shortBreak') ?? 30;
  longBreak = prefs.getInt('longBreak') ?? 30;
}

}

