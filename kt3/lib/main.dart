import 'package:flutter/material.dart';

void main() {
  runApp(StaticResourcesApp());
}

class StaticResourcesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Static Resources App',
      theme: ThemeData(fontFamily: 'CustomFont', primarySwatch: Colors.blue),
      home: ImageScreen(),
    );
  }
}

class ImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Галерея изображений')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Мои изображения',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Image.asset('assets/images/image1.png'),
                  SizedBox(height: 10),
                  Image.asset('assets/images/image2.png'),
                  SizedBox(height: 10),
                  Image.asset('assets/images/image3.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
