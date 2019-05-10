import 'package:flutter/material.dart';

//一个cardcell

class MyCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCardState();
  }
}

class MyCardState extends State<MyCard> {
  var _selected = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        title: Text('标题'),
        subtitle: Text("副标题"),
        leading: Icon(
          Icons.email,
          color: Colors.red,
        ),
        trailing: Checkbox(
            value: _selected,
            onChanged: (bool change) {
              setState(() {
                _selected = change;
              });
            }),
      ),
    );
  }
}
