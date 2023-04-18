

import 'dart:convert';

import 'package:ceee_manager/util/theme_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
class ImageSearchPage extends StatefulWidget {
  Function(String url) selectEvent;

  String? keywords;

  ImageSearchPage(this.keywords,this.selectEvent, {super.key});

  @override
  _ImageSearchPageState createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _imageUrls = [];


  @override
  void initState() {
    super.initState();
    _searchController.text=widget.keywords??"";
    _searchImages(_searchController.text);
  }

  Future<void> _searchImages(String query) async {
    try {
      // 输入搜索关键词和要获取的图片数量
      String keyword = query;
      int num_images = 20;

      // 构造请求URL
      String url = 'https://www.bing.com/images/search?q=$keyword&count=$num_images';

      setState(() {
        _imageUrls.clear();
      });
      // 发送请求，获取响应结果
      Response response = await Dio().get(url);
      Document document = parse(response.data);

      // 解析响应结果，获取图片URL列表
      List<String> image_urls = [];
      document.querySelectorAll('a.iusc').forEach((element) {
        Map<String, dynamic> m = jsonDecode(element.attributes['m']!);
        image_urls.add(m['turl']);
        print(m['turl']);
      });

      // 打印图片URL列表

      for (String u in image_urls) {
        _imageUrls.add(u);
      }
      setState(() {

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _searchController,
          style: ThemeUtil.isDarkMode(context)?TextStyles.textDark:TextStyles.text,
          // decoration: InputDecoration(
          //   hintText: 'Search images',
          // ),
          onSubmitted: (query) => _searchImages(query),
        ),
      ),
      body: _imageUrls.length==0?Center(child:CircularProgressIndicator()):GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return InkWell(child: Image.network(
            _imageUrls[index],
            fit: BoxFit.cover,
          ),onTap: (){
            Navigator.maybePop(context);
            widget.selectEvent.call(_imageUrls[index]);
          },);
        },
      ),
    );
  }
}
