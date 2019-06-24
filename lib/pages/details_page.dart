import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/details_page/details_explain.dart';
import 'package:flutter_shop/provide/details_info.dart';
import 'package:path/path.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_area.dart';
import 'details_page/details_tabbar.dart';

class DetailsPage extends StatelessWidget {
  String goodsId = "";
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getGoodsInfo(context, '${goodsId}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页面'),
      ),
      body: FutureBuilder(
        future: _getGoodsInfo(context, '${goodsId}'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ListView(
                children: <Widget>[
                  DetailsTopArea(),
                  DetailsExplain(),
                  DetailsTabbar(),
                ],
              ),
            );
          } else {
            return Text('加载中');
          }
        },
      ),
    );
  }

  Future _getGoodsInfo(BuildContext context, String goodsId) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
