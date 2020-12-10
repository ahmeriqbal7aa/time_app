import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  /////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// TIMER CODE /////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////
  //TODO Timer Variables
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "";
  // bool variables is defined to use to
  // enable/disable the Buttons when it pressed
  bool started = true;
  bool stopped = true;
  int timefortimer;
  bool canceltimer = false;

  //TODO Start Function for Timer()
  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    //TODO Convert Time in Seconds
    timefortimer = ((hour * 3600) + (min * 60) + sec);
    // we give a "timer" in place of "callback"
    // bcz we don't want to run timer continuously
    // so we need to stop timer running continuously
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timefortimer < 1 || canceltimer == true) {
          t.cancel();
          // if we want to reset the (time selector) timer
          // then write the following line of code
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else if (timefortimer < 60) {
          timetodisplay = timefortimer.toString();
          timefortimer = timefortimer - 1;
        } else if (timefortimer < 3600) {
          int m = timefortimer ~/ 60;
          int s = timefortimer - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        } else {
          int h = timefortimer ~/ 3600;
          int x = timefortimer - (3600 * h);
          int m = x ~/ 60;
          int s = x - (60 * m);
          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer - 1;
        }
      });
    });
  }

  //TODO Stop Function for timer() Buttons
  void stop() {
    setState(() {
      started = true;
      stopped = true;
      canceltimer = true;
      // if we want to empty time's text where the running time is displaying
      // then write the following line of code
      timetodisplay = "";
    });
  }

  //TODO Define Tab Controller Class
  TabController tb;
  //TODO Override the initState(){}
  @override
  void initState() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  //TODO Create Timer Function that return a Widget
  Widget timer() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'HH',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 80.0,
                      textStyle: TextStyle(fontFamily: 'Times New Roman'),
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'MM',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 80.0,
                      textStyle: TextStyle(fontFamily: 'Times New Roman'),
                      onChanged: (value) {
                        setState(() {
                          min = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'SS',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 24,
                      listViewWidth: 80.0,
                      textStyle: TextStyle(fontFamily: 'Times New Roman'),
                      onChanged: (value) {
                        setState(() {
                          sec = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timetodisplay,
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: started ? start : null,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: stopped ? null : stop,
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 35.0),
                  child: Text(
                    'Stop',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////// STOP WATCH CODE ////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////
  //TODO Stopwatch Variables
  // bool variables is defined to use to
  // enable/disable the Buttons when it pressed
  bool startispressed = true;
  bool stopispressed = true;
  bool resetispressed = true;
  String stoptimetodisplay = "00:00:00";
  var swatch = Stopwatch();

  void starttimer() {
    Timer(Duration(seconds: 1), keeprunning);
  }

  // "Keep Running" is the callback function of timer
  void keeprunning() {
    if (swatch.isRunning) {
      starttimer();
    }
    setState(() {
      stoptimetodisplay = swatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  //TODO Below are Functions for stopwatch() Buttons
  void startstopwatch() {
    setState(() {
      startispressed = false;
      stopispressed = false;
    });
    swatch.start();
    starttimer();
  }

  void stopstopwatch() {
    setState(() {
      stopispressed = true;
      resetispressed = false;
    });
    swatch.stop();
  }

  void resetstopwatch() {
    setState(() {
      resetispressed = true;
      startispressed = true;
    });
    swatch.reset();
    stoptimetodisplay = "00:00:00";
  }

  //TODO Create Stopwatch Function that return a Widget
  Widget stopwatch() {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                stoptimetodisplay,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Times New Roman',
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: stopispressed ? null : stopstopwatch,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 35.0),
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: resetispressed ? null : resetstopwatch,
                        color: Colors.blueGrey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 35.0),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Times New Roman',
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: startispressed ? startstopwatch : null,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Times New Roman',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Time Project',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
            fontFamily: 'Times New Roman',
          ),
        ),
        //TODO Tab Bar
        bottom: TabBar(
          tabs: [
            Text('Timer'),
            Text('Stopwatch'),
          ],
          controller: tb,
          labelStyle: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Times New Roman',
          ),
          labelPadding: EdgeInsets.only(bottom: 10.0),
          unselectedLabelColor: Colors.white60,
        ),
      ),
      //TODO Tab Bar View
      body: TabBarView(
        children: [
          //TODO Caller Timer Function
          timer(),
          //TODO Caller Stopwatch Function
          stopwatch(),
        ],
        // here below we also give/write controller
        // bcz it will work only when both controller would be same
        controller: tb,
      ),
    );
  }
}
