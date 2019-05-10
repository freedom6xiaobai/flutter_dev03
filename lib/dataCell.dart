import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

//多条数据

class MyDataCard extends StatefulWidget {
  MyDataCard({Key key, this.title, @required this.listArray}) : super(key: key);
  final List<String> listArray;
  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyDataCardState();
  }
}

class MyDataCardState extends State<MyDataCard> {
  final _saveSelectedList = new Set<int>();

  //-------内部
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),

//      body: ListView.builder(
//          itemCount: widget.listArray.length,
//          itemBuilder: (content, index) {
//            final isSelected = _saveSelectedList.contains(index);
//            return ListTile(
//              title: Text('测试 ${widget.listArray[index]}'),
//              leading: Icon(Icons.receipt,
//                  color: isSelected ? Colors.yellow : Colors.red),
//              trailing: Text('滚🥚'),
//              subtitle: Text('哈哈哈😄'),
//              onTap: () {
//                setState(() {
//                  if (isSelected) {
//                    _saveSelectedList.remove(index);
//                  } else {
//                    _saveSelectedList.add(index);
//                  }
//                });
//              },
//            );
//          }),
    );
  }

  //------放外面
  //要完成展示数据和保存点击后的数据，这里分别用数组和set来存储（用set存储点击后的数据是因为set可以去重，你也可以选择其他的存储方式）
  final _suggestions = <WordPair>[]; //分析 1. Dart中加上 _表示私有化
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0); //分析 2.表示字体大小的常量
  //section 列表
  //表示创造数据集和构建ListView：
  //1. _buildSuggestions方法就是返回一个ListView
  Widget _buildSuggestions() {
    _suggestions.addAll(generateWordPairs().take(2));
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return new Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
//          if (index >= _suggestions.length) {
//            // ...接着再生成10个单词对，然后添加到建议列表
//            _suggestions.addAll(generateWordPairs().take(10));
//          }

          return _buildRow(_suggestions[index]);
        });
  }

  //2. _buildRow方法就是返回ListView中的一行（ListTile）如何展示
  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

//添加_pushSaved方法表示如何跳转到新的页面并展示选中的数据：
  void _pushSaved() {
    Navigator.of(context).push(
      // 分析 1
      new MaterialPageRoute(
        // 分析 2
        builder: (context) {
          final tiles = _saved.map(
            //数据
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            // 分析 3
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
//  分析：
//1.使用Navigator.of(context).push的方式来处理跳转，需要的参数是一个Route
//2.创建页面Route
//3.返回一个新的里面，里面的body内容是一个ListView，展示的是_saved中读取出来的数据

}
