// 导入 Flutter 核心库
import 'package:flutter/material.dart';

// 详情页组件
class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 创建 Scaffold 组件
    return Scaffold(
      // 设置 Scaffold 组件的 AppBar
      appBar: AppBar(
        title: Text('Detail'),
      ),
      // 设置 Scaffold 组件的主体内容
      body: Center(
        // 创建一个 Text 组件
        child: Text('This is the detail page.'),
      ),
    );
  }
}