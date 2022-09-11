import 'dart:io';

import 'package:cyclop/cyclop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final imagePicker = ImagePicker();
  Color selectedColor = Colors.white;
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          EyeDrop(
            child: Builder(
              builder: (context) => Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: selectedImage == null
                        ? null
                        : BoxDecoration(
                            image:
                                DecorationImage(image: FileImage(selectedImage!))),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: ColorButton(
                          key: const Key('c1'),
                          color: selectedColor,
                          size: 32,
                          elevation: 5,
                          onColorChanged: (value) =>
                              setState(() => selectedColor = value),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            child: SizedBox(
                width: 200,
                child: ElevatedButton(
                    onPressed: _selectImage, child: const Text('Select Image'))),
          )
        ],
      ),
    );
  }

  Future<void> _selectImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
