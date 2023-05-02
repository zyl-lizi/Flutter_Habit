import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _seconds = 0;
  int _workTime = 25;
  int _breakTime = 5;
  Timer? _timer;
  bool _isWorking = true;
  bool _isPaused = true;

  void _startTimer() {
    _isPaused = false;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds--;
      });
      if (_seconds == 0) {
        _isWorking = !_isWorking;
        if (_isWorking) {
          _seconds = _workTime * 60;
        } else {
          _seconds = _breakTime * 60;
        }
      }
    });
  }

  void _pauseTimer() {
    if(_timer != null) {
      setState(() {
        _isPaused = true;
      });
      _timer!.cancel();
      _timer = null;
    }
  }

  void _resetTimer() {
    if(_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    setState(() {
      _seconds = _workTime * 60;
      _isWorking = true;
      _isPaused = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pomodoro Timer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_isWorking ? 'Work Time' : 'Break Time', style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              Text('${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}', style: TextStyle(fontSize: 48)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('Start'),
                    onPressed: _isPaused ? _startTimer : null,
                  ),
                  ElevatedButton(
                    child: Text('Pause'),
                    onPressed: !_isPaused ? _pauseTimer : null,
                  ),
                  ElevatedButton(
                    child: Text('Reset'),
                    onPressed: _resetTimer,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Work Time: $_workTime minutes'),
              Slider(
                value: _workTime.toDouble(),
                min: 1,
                max: 60,
                divisions: 59,
                onChanged: (value) {
                  setState(() {
                    _workTime = value.toInt();
                    if (_isWorking) {
                      _seconds = _workTime * 60;
                    }
                  });
                },
              ),
              Text('Break Time: $_breakTime minutes'),
              Slider(
                value: _breakTime.toDouble(),
                min: 1,
                max: 30,
                divisions: 29,
                onChanged: (value) {
                  setState(() {
                    _breakTime = value.toInt();
                    if (!_isWorking) {
                      _seconds = _breakTime * 60;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}