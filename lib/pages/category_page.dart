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
import '../provide/category_goods_list.dart';

var categoryId;

//分类页面
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

//左侧菜单的子控件
  Widget _leftInkWell(int index) {
    bool isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        //TODO
        var childList = list[index].bxMallSubDto;
        var leftcategoryId = list[index].mallCategoryId;
        Provide.value<RightChildTopCategoryProvide>(context)
            .getChildCategory(childList, leftcategoryId);
        Provide.value<RightChildTopCategoryProvide>(context)
            .changeChildIndex(0, "");
        _getGoodsList(categoryId: leftcategoryId);
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

        Provide.value<RightChildTopCategoryProvide>(context)
            .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
        _getGoodsList(categoryId: list[0].mallCategoryId);
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

  //根据大类的不同以及右侧顶部的小分类不同，获取不同的商品列表 -- 点击大类时需要，点击小类时也需要此方法
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1,
    };
    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      //更新商品列表的数据
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsList.data);
      // print("商品分类列表数据》》》》》》》${data}");
    });
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
      child: Provide<RightChildTopCategoryProvide>(
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
                return _rightInkWell(
                  index,
                  childCategory.childCategoryList[index],
                );
              },
            ),
          );
        },
      ),
    );
  }

//右侧顶部菜单子item
  Widget _rightInkWell(index, BxMallSubDto item) {
    bool isCheck = false;
    isCheck = (index ==
            Provide.value<RightChildTopCategoryProvide>(context).childIndex)
        ? true
        : false;
    return InkWell(
      onTap: () {
        Provide.value<RightChildTopCategoryProvide>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(categorySubId: item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(26),
            color: isCheck ? Colors.pink : Colors.black,
          ),
        ),
      ),
    );
  }

  //根据大类的不同以及右侧顶部的小分类不同，获取不同的商品列表 -- 点击大类时需要，点击小类时也需要此方法
  void _getGoodsList({String categorySubId}) async {
    var data = {
      'categoryId':
          Provide.value<RightChildTopCategoryProvide>(context).leftCategoryId,
      'categorySubId': categorySubId,
      'page': 1,
    };
    await request(GET_MALL_GOODS, formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        //更新商品列表的数据
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(null);
      } else {
        //更新商品列表的数据
        Provide.value<CategoryGoodsListProvide>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
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
    // _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //采用listView控件实现
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        if (data.goodslist == null || data.goodslist.length == 0) {
          return Text('暂时没有数据');
        } else {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(560),
              child: ListView.builder(
                itemCount: data.goodslist.length,
                itemBuilder: (context, index) {
                  return _listWidget(data.goodslist, index);
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _listWidget(List newlist, index) {
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
            _goodsImage(newlist, index),
            Column(
              children: <Widget>[
                _goodsName(newlist, index),
                _goodsPrice(newlist, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //商品图片
  Widget _goodsImage(List newlist, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newlist[index].image),
    );
  }

//商品名称
  Widget _goodsName(List newlist, index) {
    return Container(
      padding: EdgeInsets.all(5),
      width: ScreenUtil().setWidth(360),
      child: Text(
        newlist[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(26)),
      ),
    );
  }

  Widget _goodsPrice(List newlist, index) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(360),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${newlist[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newlist[index].oriPrice}',
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
