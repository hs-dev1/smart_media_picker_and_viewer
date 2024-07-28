// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'utils.dart';

class PDFViewWidget extends StatefulWidget {
  final String path;
  final bool isForSubmit;
  final Color? appBarColor;
  final Color? buttonColor;
  final TextStyle? errorTextStyle;

  const PDFViewWidget({
    super.key,
    required this.path,
    this.isForSubmit = true,
    this.appBarColor,
    this.buttonColor,
    this.errorTextStyle,
  });

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFViewWidget> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
            backgroundColor: widget.appBarColor ?? Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: InkWell(
                // onTap: () => Get.back(result: false),
                onTap: () => Navigator.pop(context, true),
                child:
                    const Icon(Icons.arrow_back_rounded, color: Colors.black),
              ),
              title: Text(
                  widget.path.split('/').last.substring(
                      0, widget.path.split('/').last.lastIndexOf('.')),
                  style: const TextStyle(color: Colors.black, fontSize: 14)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        PDFView(
                          filePath: widget.path,
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: true,
                          pageSnap: true,
                          defaultPage: currentPage!,
                          fitPolicy: FitPolicy.BOTH,
                          preventLinkNavigation:
                              false, // if set to true the link is handled in flutter
                          onRender: (_pages) {
                            setState(() {
                              pages = _pages;
                              isReady = true;
                            });
                          },
                          onError: (error) {
                            setState(() {
                              errorMessage = error.toString();
                            });
                            debugPrint(error.toString());
                          },
                          onPageError: (page, error) {
                            setState(() {
                              errorMessage = '$page: ${error.toString()}';
                            });
                            debugPrint('$page: ${error.toString()}');
                          },
                          onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                          },
                          onLinkHandler: (String? uri) {
                            debugPrint('goto uri: $uri');
                          },
                          onPageChanged: (int? page, int? total) {
                            debugPrint('page change: $page/$total');
                            setState(() {
                              currentPage = page;
                            });
                          },
                        ),
                        if (errorMessage.isEmpty)
                          !isReady
                              ? const Center(child: CircularProgressIndicator())
                              : Container()
                        else
                          Center(
                            child: Text(errorMessage),
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.isForSubmit)
                    Container(
                      height: MediaQuery.of(context).size.height * .07,
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: AppButton(
                        buttonTitle: "Submit",
                        color: widget.buttonColor ?? Colors.teal.shade400,
                        textColor: Colors.white,
                        // onTap: () => Get.back(result: true),
                        onTap: () => Navigator.pop(context, true),
                        textSize: 12,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        isCourierFont: false,
                      ),
                    )
                  else
                    const SizedBox(height: 10),
                ],
              ),
            )),
      ),
    );
  }

  Widget detailsRow({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            height: 7,
            width: 7,
            decoration: BoxDecoration(
                color: Colors.teal.shade400, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.red, fontSize: 10),
          )
        ],
      ),
    );
  }
}
