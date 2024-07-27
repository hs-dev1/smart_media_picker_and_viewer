// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'image_view.dart';

class ImageSlider extends StatefulWidget {
  final int index;
  final List<File> sliderList;

  final double aspectRatio;
  final Duration autoPlayInterval;

  const ImageSlider({
    super.key,
    required this.index,
    required this.sliderList,
    this.aspectRatio = 10 / 12,
    this.autoPlayInterval = const Duration(seconds: 4),
  });

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  CarouselController carouselController = CarouselController();
  List<File> sortedImagesList = [];
  @override
  void initState() {
    sortedImagesList = widget.sliderList
        .where((element) => element.path.split(".").last.toString() == "png" || element.path.split(".").last.toString() == "jpg" || element.path.split(".").last.toString() == "jpeg")
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .2),
      child: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            aspectRatio: widget.aspectRatio,
            autoPlay: true,
            initialPage: widget.index,
            autoPlayInterval: widget.autoPlayInterval,
            enlargeCenterPage: true,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 0.6,
          ),
          items: sortedImagesList
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageView(path: item, isForSubmit: false)));
                      },
                      child: Image.file(item, fit: BoxFit.fill),
                    ),
                  ))
              .toList()),
    );
  }
}
