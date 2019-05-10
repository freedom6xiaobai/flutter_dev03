import 'package:flutter/material.dart';

//列子商品选择

typedef void CartChangedCallback(ProductModel product, bool inCart);

class ProductModel {
  //数据
  const ProductModel({this.name});

  final String name;
}

class ShopListView extends StatefulWidget {
  ShopListView({Key key, this.dataArray}) : super(key: key);
  final List<ProductModel> dataArray;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopListViewState();
  }
}

class ShopListViewState extends State<ShopListView> {
  Set<ProductModel> _shopCart = Set<ProductModel>();


  void _handleCartChanged(ProductModel product, bool inCart) {
    setState(() { //调用setState会触发重新构建界面
      if (inCart)
        _shopCart.add(product);
      else
        _shopCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: widget.dataArray.map((ProductModel model) {
        return _shopListCell(//构建cell
          product: model,
          inCart: _shopCart.contains(model), //传递inCart值
          onCartChanged: _handleCartChanged,//传递点击函数
            );
      }).toList(),
    );
  }
}

class _shopListCell extends StatelessWidget {
  _shopListCell({ProductModel product, this.inCart, this.onCartChanged})
      : product = product,
        super(key: ObjectKey(product));
  final ProductModel product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context){
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;//根据inCart不同值显示不同颜色
  }

  TextStyle _getTextStyle(BuildContext context){
    if(!inCart)return null;
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(//构造cell
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name,style: _getTextStyle(context),),
      onTap: (){ //点击方法，调用父控件传递过来的方法
        onCartChanged(product,!inCart);
      },
    );
  }
}
