import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/syncfusion_widget.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);


  @override
  _FirstPageState createState() => _FirstPageState();

}

class _FirstPageState extends State<FirstPage> {

  bool _isHorizontalOrientation = true;


  double progressValue = 0; // 시작하는 프로그래스 값
  double _size = 150;
  late Timer _timer;

  String weekTimeString = "04:33:01";
  String monthTimeString = "16:00:30";

  //0부터 시작해서 차오르는 프로그래스 바를 위한 초기화
  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer _timer) {
        setState(() {
          if(progressValue != 60) {
            progressValue++;
          }
        });
      });
    }
  }

  // void _getTime() {
  //   final String formattedDateTime =
  //   DateFormat('kk:mm:ss').format(DateTime.now()).toString();
  //   setState(() {
  //     _timeString = formattedDateTime;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swiper"),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context,int index){
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/study.jpg'),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                  fit: BoxFit.fill),
              borderRadius:  BorderRadius.circular(16.0),
              ),
            child:
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("일일 통계", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  getProgressBarWithCircle(_size,progressValue),
                  Container(
                    child: Text("총 누적시간", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text("주간", style:  TextStyle(color: Colors.white, fontSize: 16)),
                    Text(weekTimeString, style:  TextStyle(color: Colors.white, fontSize: 16)),
                    Text("첫째주 기준", style:  TextStyle(color: Colors.white, fontSize: 16)),
                  ],),
                  //buildCategoryAxis(context),
                ],
              ),
            margin: EdgeInsets.only(bottom: 96),
          );
        },
        itemHeight: 100,
        itemCount: 3,
        viewportFraction: 0.8,
        scale: 0.9,
        indicatorLayout: PageIndicatorLayout.COLOR,
        pagination: const SwiperPagination(
            builder: SwiperPagination.fraction),
      ),
    );
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}



