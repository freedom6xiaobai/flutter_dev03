import 'package:flutter/material.dart';

//几个cell
//垂直的列表

class MyFewCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyFewCardState();
  }
}

class MyFewCardState extends State<MyFewCard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      //默认垂直vertical/水平horizontal
      scrollDirection: Axis.vertical,
      children: <Widget>[
        _getContainer('test01', Icons.record_voice_over),
        _getContainer('test02', Icons.phone),
        _getContainer('test03', Icons.vibration),
      ],
    );
  }

  /**
   * 抽取item项
   */
  Widget _getContainer(String test, IconData icon) {
    return new Container(
      width: 375.0,
      height: 100.0,
//      ListTile
      child: new ListTile(
//       显示在title之前
        leading: new Icon(icon),
//        显示在title之后
        trailing: new Icon(icon),
        title: new Text(test),
        subtitle: new Text("我是subtitle"),
      ),

    );
  }
}
