// ignore_for_file: deprecated_member_use, must_be_immutable, use_super_parameters, library_private_types_in_public_api, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'src/image_slider.dart';
import 'src/image_view.dart';
import 'src/pdf_view_widget.dart';
import 'src/utils.dart';
import 'package:open_file/open_file.dart';

class SmartMediaPickerAndViewer extends StatefulWidget {
  List<File> list;
  ValueSetter<dynamic> onSelect;
  final bool isHideUploadButton;
  final Color? uploadButtonColor;
  final TextStyle? uploadButtonTextStyle;
  final Widget? uploadButtonIcon;
  final TextStyle? mediaTextStyle;
  final Color? removeIconColor;
  final Widget? removeIcon;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? mediaHeight;
  final double? mediaWidth;
  final double? buttonPadding;
  final double? removeIconSize;

  SmartMediaPickerAndViewer({
    Key? key,
    required this.list,
    required this.isHideUploadButton,
    required this.onSelect,
    this.uploadButtonColor,
    this.uploadButtonTextStyle,
    this.uploadButtonIcon,
    this.mediaTextStyle,
    this.removeIconColor,
    this.removeIcon,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.mediaHeight,
    this.mediaWidth,
    this.removeIconSize,
  }) : super(key: key);

  @override
  _SmartMediaPickerAndViewerState createState() => _SmartMediaPickerAndViewerState();
}

class _SmartMediaPickerAndViewerState extends State<SmartMediaPickerAndViewer> {
  List<File> list = [];
  final picker = ImagePicker();

  Future<FilePickerResult> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'png',
        'jpg',
        'jpeg',
      ],
    );
    return result!;
  }

  Future<File> getImage(bool fromCamera) async {
    File? image;
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        log(image.toString());
      } else {
        debugPrint('No image selected.');
      }
    });
    return image!;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        for (var element in widget.list) {
          list.add(element);
          widget.onSelect(list);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!widget.isHideUploadButton)
          InkWell(
            onTap: () {
              // Get.bottomSheet(uploadSheet());
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return uploadSheet();
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                children: [
                  Container(
                    width: widget.buttonWidth ?? MediaQuery.of(context).size.width * .15,
                    height: widget.buttonHeight ?? MediaQuery.of(context).size.width * .15,
                    padding: EdgeInsets.all(widget.buttonPadding ?? 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: widget.uploadButtonColor ?? Colors.blueGrey),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.transparent,
                    ),
                    child: widget.uploadButtonIcon ?? Icon(Icons.upload, color: widget.uploadButtonColor ?? Colors.blueGrey),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Upload",
                    style: widget.uploadButtonTextStyle ?? TextStyle(color: widget.uploadButtonColor ?? Colors.black),
                  )
                ],
              ),
            ),
          ),
        if (!widget.isHideUploadButton) const SizedBox(width: 5),
        Expanded(
          child: Wrap(
            children: List.generate(list.length, (index) {
              return Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          String fileType = list[index].path.split('.').last.toString();
                          // debugPrint(fileType.camelCase);
                          (fileType == FileTypeEnum.jpg.name || fileType == FileTypeEnum.jpeg.name || fileType == FileTypeEnum.png.name)
                              ? showDialog(context: context, builder: (context) => ImageSlider(index: index, sliderList: list))
                              : (fileType == FileTypeEnum.pdf.name)
                                  ?
                                  // Get.to(() => PDFViewWidget(path: list[index].path, isForSubmit: false))
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PDFViewWidget(path: list[index].path, isForSubmit: false),
                                      ),
                                    )
                                  : await OpenFile.open(list[index].path);
                        },
                        child: (list[index].path.split('.').last.toString() == FileTypeEnum.jpg.name ||
                                list[index].path.split('.').last.toString() == FileTypeEnum.jpeg.name ||
                                list[index].path.split('.').last.toString() == FileTypeEnum.png.name)
                            ? Container(
                                margin: const EdgeInsets.only(top: 5, left: 5, right: 2),
                                width: widget.mediaWidth ?? MediaQuery.of(context).size.width * .15,
                                height: widget.mediaHeight ?? MediaQuery.of(context).size.width * .15,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: FileImage(list[index]), fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                                    width: widget.mediaWidth ?? MediaQuery.of(context).size.width * .15,
                                    height: widget.mediaHeight ?? MediaQuery.of(context).size.width * .15,
                                    decoration: BoxDecoration(
                                      color: (list[index].path.split('.').last.toString() == FileTypeEnum.pdf.name)
                                          ? Colors.red
                                          : (list[index].path.split('.').last.toString() == FileTypeEnum.xls.name || list[index].path.split('.').last.toString() == FileTypeEnum.xlsx.name)
                                              ? Colors.green
                                              : Colors.blue,
                                      border: Border.all(color: Colors.white, width: .4),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.elliptical(22, 22),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Text(
                                          (list[index].path.split('.').last.toString() == FileTypeEnum.pdf.name)
                                              ? "pdf"
                                              : (list[index].path.split('.').last.toString() == FileTypeEnum.xls.name || list[index].path.split('.').last.toString() == FileTypeEnum.xlsx.name)
                                                  ? "xlsx"
                                                  : "doc",
                                          style: const TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                        color: Colors.white54,
                                        border: Border.all(color: Colors.white, width: 3),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.elliptical(99, 99),
                                          bottomLeft: Radius.circular(12),
                                        )),
                                  ),
                                ],
                              ),
                        // Container(
                        //     margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                        //     width: widget.mediaWidth ?? MediaQuery.of(context).size.width * .15,
                        //     height: widget.mediaHeight ?? MediaQuery.of(context).size.width * .15,
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //             image: AssetImage(
                        //               (list[index].path.split('.').last.toString() == FileTypeEnum.pdf.name)
                        //                   ? pdf
                        //                   : (list[index].path.split('.').last.toString() == FileTypeEnum.xls.name || list[index].path.split('.').last.toString() == FileTypeEnum.xlsx.name)
                        //                       ? xls
                        //                       : doc,
                        //             ),
                        //             fit: BoxFit.cover),
                        //         borderRadius: BorderRadius.circular(8)),
                        //   ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${list[index].path.split('/').last.length >= 5 ? list[index].path.split('/').last.substring(0, 5) : list[index].path.split('/').last}.${list[index].path.split('.').last}",
                        style: widget.mediaTextStyle ??
                            const TextStyle(
                              color: Colors.black,
                            ),
                      )
                    ],
                  ),
                  widget.isHideUploadButton
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            setState(() {
                              list.removeAt(index);
                            });
                          },
                          child: widget.removeIcon ??
                              Container(
                                  height: widget.removeIconSize ?? 20,
                                  width: widget.removeIconSize ?? 20,
                                  decoration: BoxDecoration(color: widget.removeIconColor ?? Colors.blueGrey, shape: BoxShape.circle),
                                  child: Center(child: Icon(Icons.close, color: Colors.white, size: widget.removeIconSize ?? 14))),
                        )
                ],
              );
            }),
          ),
        )
      ],
    );
  }

  Widget uploadSheet() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(26), topLeft: Radius.circular(26)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .20,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                uploadType(icon: Icons.description_rounded, title: 'Document', index: 0),
                uploadType(icon: Icons.camera_alt_rounded, title: 'Camera', index: 1),
                uploadType(icon: Icons.image, title: 'Gallery', index: 2),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ));
  }

  Widget uploadType({required IconData icon, required String title, required int index}) {
    return GestureDetector(
      onTap: () async {
        switch (index) {
          case 0:
            {
              try {
                debugPrint(' Document');
                bool isSubmitted = false;

                var result = await pickFiles();
                String fileType = result.files.first.path!.split('.').last.toString();
                if ((fileType == FileTypeEnum.jpg.name || fileType == FileTypeEnum.jpeg.name || fileType == FileTypeEnum.png.name)) {
                  // isSubmitted = await Get.to(ImageView(path: File(result.files.first.path!)));
                  isSubmitted = await Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(path: File(result.files.first.path!))));
                } else if (fileType == FileTypeEnum.pdf.name) {
                  // isSubmitted = await Get.to(() => PDFViewWidget(path: result.files.first.path!));
                  isSubmitted = await Navigator.push(context, MaterialPageRoute(builder: (context) => PDFViewWidget(path: result.files.first.path!)));
                } else {
                  await OpenFile.open(result.files.first.path!);
                  isSubmitted = true;
                }

                if (isSubmitted) {
                  setState(() {
                    List<File> selectedFiles = [];
                    selectedFiles = result.paths.map((path) => File(path!)).toList();
                    selectedFiles.forEach((element) {
                      list.add(element);
                    });
                    widget.onSelect(list);
                  });
                }
                // Get.back();
                Navigator.pop(context);
              } catch (e) {
                log("ERROR ON FILE PICKER 300 Line ${e.toString()}");
              }
            }
            break;
          case 1:
            debugPrint(' Camera');

            var result = await getImage(true);

            bool isSubmitted = await Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(path: File(result.path))));
            //  Get.to(ImageView(
            //   path: File(result.path),
            // ));

            if (isSubmitted) {
              setState(() {
                List<File> selectedFiles = [];
                selectedFiles = [File(result.path)];
                selectedFiles.forEach((element) {
                  list.add(element);
                });
                widget.onSelect(list);
              });
            }

            // Get.back();
            Navigator.pop(context);

            break;
          case 2:
            var result = await getImage(false);

            // bool isSubmitted = await Get.to(ImageView(path: File(result.path)));
            bool isSubmitted = await Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(path: File(result.path))));

            if (isSubmitted) {
              setState(() {
                List<File> selectedFiles = [];
                selectedFiles = [File(result.path)];
                selectedFiles.forEach((element) {
                  list.add(element);
                });
                widget.onSelect(list);
              });
            }

            // Get.back();
            Navigator.pop(context);

            break;
        }
      },
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: Colors.teal.shade400,
            ),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  icon,
                  color: Colors.teal.shade400,
                  size: 25,
                )),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
