import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 购物车页面
class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> testList = [];
  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: testList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testList[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: () {
              _clear();
            },
            child: Text('清除'),
          ),
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String temp = '哈哈哈哈a';
    testList.add(temp);
    pref.setStringList('testinfo', testList);
    _show();
  }

  void _show() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      if (pref.getStringList("testinfo") != null) {
        testList = pref.getStringList("testinfo");
      }
    });
  }

  void _clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('testinfo');
    setState(() {
      testList = [];
    });
  }
}
