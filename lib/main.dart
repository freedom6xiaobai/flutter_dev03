import 'package:flutter/material.dart';
import 'oneCell.dart';
import 'fewCell.dart';
import 'dataCell.dart';
import 'example_ShopCell.dart';

//listview 列表展示

void main() => runApp(HomeApp());

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String title = "多条数据列表";
    // TODO: implement build
    // 1。一个cardcell/多个cell
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.yellow),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("ListTile"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add_a_photo), onPressed: _pushSaveClick)
           ],
        ),
//        body: MyCard(),//一个
//        body: MyFewCard(), //多个/水平
          body: ShopListView(
            dataArray: <ProductModel>[
              ProductModel(name: 'testName1'),
              ProductModel(name: 'testName2'),
              ProductModel(name: 'testName3')
            ],
          ),
      ),

      //3.多条数据
//      home: MyDataCard(title: title,listArray: List.generate(5, (i) => "第${i+1}条")),
    );
  }

  void _pushSaveClick() {
    print('_pushSaveClick envent');
  }
}
