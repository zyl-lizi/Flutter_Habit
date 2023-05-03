import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

void main() {
  // 注册image_picker插件
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.platform.invokeMethod('SystemChrome.setPreferredOrientations', ['portraitUp'])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter相册',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter相册'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _imageList = [];

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageList.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.builder(
        itemCount: _imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.file(_imageList[index], fit: BoxFit.cover),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: InteractiveViewer(
                      child: Image.file(_imageList[index]),
                    ),
                  ),
                );
              }));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: '添加图片',
        child: Icon(Icons.add),
      ),
    );
  }
}