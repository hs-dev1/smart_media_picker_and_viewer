
# Smart Media Picker and Viewer

A versatile Flutter package for seamlessly picking and viewing various media types including images, PDFs, and other files. This package provides customizable widgets to enhance the media handling experience in your Flutter applications.

## Features

- Media Picker: Easily pick files, images, and documents with a customizable UI.
- Media Viewer: View images and PDF files within your app with built-in support.
- Customizable: Adjust styles, colors, and other UI elements to fit your application's design.
- Flexible Supports: wide range of file types and provides various options for display and interations.

## Installation

Add `smart_media_picker_and_viewer` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  smart_media_picker_and_viewer: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

To use the package, import it into your Dart file:

```dart
import 'package:smart_media_picker_and_viewer/smart_media_picker_and_viewer.dart';
```

### Example

Here's a simple example of how to use the `SmartMediaPickerAndViewer` widget:

```dart
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
  List<File> documentList = [];
  List<File> bankStatementList = [File("pdf")];

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
              list: documentList,
              isHideUploadButton: false,
              uploadButtonColor: Colors.blueGrey,
              uploadButtonTextStyle: const TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.blueGrey),
              mediaTextStyle: const TextStyle(fontSize: 8, fontStyle: FontStyle.italic, color: Colors.blueGrey),
              removeIconColor: Colors.red,
              removeIconSize: 20,
              buttonHeight: 80,
              buttonWidth: 60,
              buttonPadding: 0,
              mediaHeight: 80,
              mediaWidth: 60,
              onSelect: (list) {
                documentList = list;
              },
            ),
            const Divider(),
            const Text(
              "Your Documents",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.black, fontSize: 15, height: 1.2),
            ),
            const SizedBox(height: 12),
            SmartMediaPickerAndViewer(
              list: bankStatementList,
              isHideUploadButton: true,
              mediaHeight: 80,
              mediaWidth: 60,
              onSelect: (list) {
                documentList = list;
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## Customization

You can customize various aspects of the `SmartMediaPickerAndViewer` widget:

- **Upload Button**:
  - `isHideUploadButton`: Hide or show the upload button.
  - `uploadButtonColor`: Set the color of the upload button.
  - `uploadButtonTextStyle`: Customize the text style of the upload button.
  - `uploadButtonIcon`: Use a custom icon for the upload button.

- **Media Display**:
  - `mediaTextStyle`: Customize the text style for media items.
  - `removeIconColor`: Set the color of the remove icon.
  - `removeIconSize`: Adjust the size of the remove icon.
  - `buttonHeight`, `buttonWidth`: Customize the size of the upload button.
  - `mediaHeight`, `mediaWidth`: Customize the size of the media items.

- **Others**:
  - `maxLinesForName`: Control the number of lines for media names.



## Additional Information

For more details, check the [GitHub repository](https://github.com/hs-dev1/smart_media_picker_and_viewer).

### Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, feel free to [open an issue](https://github.com/hs-dev1/smart_media_picker_and_viewer/issues) or submit a pull request.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

