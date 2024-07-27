// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';

import 'utils.dart';

class ImageView extends StatefulWidget {
  final File path;
  final bool isForSubmit;
  final Color? appBarColor;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;

  const ImageView({
    super.key,
    required this.path,
    this.isForSubmit = true,
    this.appBarColor,
    this.buttonColor,
    this.buttonTextStyle,
  });

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: InkWell(
              // onTap: () => Get.back(result: false),
              onTap: () => Navigator.pop(context, true),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.black),
            ),
            title: Text(widget.path.path.split('/').last.substring(0, widget.path.path.split('/').last.lastIndexOf('.')), style: const TextStyle(color: Colors.black, fontSize: 14)),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(widget.path), fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
          bottomNavigationBar: widget.isForSubmit
              ? Container(
                  height: MediaQuery.of(context).size.height * .07,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: AppButton(
                    buttonTitle: "Submit",
                    color: widget.buttonColor ?? Colors.teal.shade400,
                    textColor: Colors.white,
                    // onTap: () => Get.back(result: true),
                    onTap: () => Navigator.pop(context, true),
                    textSize: 12,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox(height: 10),
        ),
      ),
    );
  }
}
