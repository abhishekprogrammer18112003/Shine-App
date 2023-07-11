import 'package:flutter/material.dart';

import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class SingleDownloadScreen extends StatefulWidget {
  String url;
  SingleDownloadScreen({super.key, required this.url});

  @override
  State<SingleDownloadScreen> createState() => _SingleDownloadScreenState();
}

class _SingleDownloadScreenState extends State<SingleDownloadScreen> {
  // TextEditingController url = TextEditingController();
  double? _progress;
  String path = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Your Report is Ready.',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Container(
            //   height: 40,
            //   width: double.infinity,
            //   child: Center(child: Text(widget.url)),
            // ),
            // const SizedBox(height: 16),
            _progress != null
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      FileDownloader.downloadFile(
                          url: widget.url,
                          onProgress: (name, progress) {
                            setState(() {
                              _progress = progress;
                            });
                          },
                          onDownloadCompleted: (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: const Duration(milliseconds: 700),
                                content: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  // padding: EdgeInsets.all(16),
                                  height: 40,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Center(
                                      child: Text(
                                    "Successfully Downloaded ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                )));
                            print('path  $value ');
                            setState(() {
                              _progress = null;
                              path = value;
                            });
                          });
                    },
                    child: const Text('Download')),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
