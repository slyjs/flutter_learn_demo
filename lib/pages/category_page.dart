import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/categoryGoodsList.dart' as prefix0;
import '../provide/child_category.dart';
import '../config/service_url.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:provide/provide.dart';
import '../config/service_url.dart';
import 'dart:async';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品类别'),
        backgroundColor: Colors.pink,
      ),
      body: Row(
        children: <Widget>[
          LeftCategoryNav(),
          Column(
            children: <Widget>[
              RightCategoryNav(),
              CategoryGoodsList(),
            ],
          )
        ],
      ),
    );
  }
}

//左侧菜单栏
class LeftCategoryNav extends StatefulWidget {
  LeftCategoryNav({Key key}) : super(key: key);

  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

//左侧菜单控件区
class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

//获取左侧菜单数据
  void _getCategory() async {
    Future.delayed(
      new Duration(seconds: 5),
      () {},
    ).then(
      (data) {
        //设置一个定时器，延时更改数据
        var data = json.decode(getCategoryData.toString());
        CategoryModel category = CategoryModel.fromJson(data);
        setState(() {
          list = category.data;
        });

        Provide.value<ChildCategory>(context)
            .getChildCategory(list[0].bxMallSubDto);
      },
    );

    // await request(GET_CATEGORY).then((val) {
    //   var data = json.decode(val.toString());
    //   print('获取左侧的菜单数据接口信息》》》》》》》》${data}');
    //   CategoryModel category = CategoryModel.fromJson(data);
    //   setState(() {
    //     list = category.data;
    //   });

    //   Provide.value<ChildCategory>(context)
    //       .getChildCategory(list[0].bxMallSubDto);
    // });
  }

//左侧菜单的子控件
  Widget _leftInkWell(int index) {
    bool isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }
}

//右侧顶部导航菜单
class RightCategoryNav extends StatefulWidget {
  RightCategoryNav({Key key}) : super(key: key);

  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<ChildCategory>(
        builder: (context, child, childCategory) {
          return Container(
            height: ScreenUtil().setHeight(80),
            width: ScreenUtil().setWidth(560),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                  width: 1,
                  color: Colors.black12,
                ))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(childCategory.childCategoryList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

//右侧顶部菜单子item
Widget _rightInkWell(BxMallSubDto item) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Text(
        item.mallSubName,
        style: TextStyle(fontSize: ScreenUtil().setSp(26)),
      ),
    ),
  );
}

///右侧商品列表控件
class CategoryGoodsList extends StatefulWidget {
  CategoryGoodsList({Key key}) : super(key: key);

  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

///右侧商品列表控件
class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List<CategoryListData> list = [];
  @override
  void initState() {
    _getGoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //采用listView控件实现
    return Container(
      width: ScreenUtil().setWidth(560),
      height: ScreenUtil().setHeight(900),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _listWidget(index);
        },
      ),
    );
  }

  void _getGoodList() async {
    var data = {
      'categoryId': '4',
      'categorySubId': '',
      'page': 1,
    };
    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      setState(() {
        list = goodsList.data;
      });
      print("商品分类列表数据》》》》》》》${data}");
    });
  }

  Widget _listWidget(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(index),
            Column(
              children: <Widget>[
                _goodsName(index),
                _goodsPrice(index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //商品图片
  Widget _goodsImage(index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

//商品名称
  Widget _goodsName(index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(360),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(360),
      child: Row(
        children: <Widget>[
          Text(
            '���格：￥${list[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
