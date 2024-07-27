import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smart_media_picker_and_viewer/smart_media_picker_and_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Media Picker And Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PackageView(),
    );
  }
}

class PackageView extends StatefulWidget {
  const PackageView({super.key});

  @override
  State<PackageView> createState() => _PackageViewState();
}

class _PackageViewState extends State<PackageView> {
  List<File> bankStatementList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Smart Media Picker And Viewer"),
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withOpacity(.1),
              spreadRadius: 12,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload Documents",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 15, height: 1.2),
            ),
            const SizedBox(height: 12),
            SmartMediaPickerAndViewer(
              list: bankStatementList,
              isHideUploadButton: false,
              uploadButtonColor: Colors.blueGrey,
              // uploadButtonIcon: const Icon(Icons.upload, color: Colors.black),
              uploadButtonTextStyle: const TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.blueGrey),
              mediaTextStyle: const TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.blueGrey),
              removeIconColor: Colors.red,
              removeIconSize: 20,
              // removeIcon: const Icon(Icons.cancel, color: Colors.red,size: 12,),
              // removeIconPositionLR8(tb):
              buttonHeight: 80,
              buttonWidth: 60,
              buttonPadding: 0,
              mediaHeight: 80,
              mediaWidth: 60,
              onSelect: (list) {
                bankStatementList = list;
              },
            ),
          ],
        ),
      ),
    );
  }
}
