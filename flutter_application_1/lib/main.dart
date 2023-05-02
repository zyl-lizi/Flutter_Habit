// 导入 Flutter 核心库
import 'package:flutter/material.dart';

// 导入自定义的 DetailPage 类
import 'detail_page.dart';

// 应用程序入口
void main() {
  // 运行应用程序
  runApp(MyApp());
}

// 应用程序的根组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 创建 MaterialApp 组件
    return MaterialApp(
      // 设置应用程序的标题
      title: 'MyApp',
      // 设置应用程序的初始路由
      initialRoute: '/',
      // 配置应用程序的路由表
      routes: {
        // 首页路由
        '/': (context) => HomePage(),
        // 详情页路由
        '/detail': (context) => DetailPage(),
      },
    );
  }
}

// 首页组件
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 创建 Scaffold 组件
    return Scaffold(
      // 设置 Scaffold 组件的 AppBar
      appBar: AppBar(
        title: Text('Home'),
      ),
      // 设置 Scaffold 组件的主体内容
      body: Center(
        // 创建一个 ElevatedButton 组件
        child: ElevatedButton(
          // 设置按钮的文本
          child: Text('Go to detail page'),
          // 设置按钮的点击事件
          onPressed: () {
            // 跳转到详情页
            Navigator.pushNamed(context, '/detail');
          },
        ),
      ),
    );
  }
}