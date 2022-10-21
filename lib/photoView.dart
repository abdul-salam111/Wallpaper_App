import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatefulWidget {
  String? Url;
  PhotoViewScreen({Key? key, this.Url}) : super(key: key);

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  ReceivePort _port = ReceivePort();
  @override
  initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void downloadImage() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      Directory? localPath = await getApplicationDocumentsDirectory();
      final savedDir = Directory(localPath.path + "PixaBay");
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      await FlutterDownloader.enqueue(
          url: widget.Url!,
          savedDir: savedDir.path,
          showNotification: true,
          openFileFromNotification: true,
          saveInPublicStorage: true);
    } else {
      print("");
    }
  }

  void setWallpaper() async {
    try {
      var file = await DefaultCacheManager().getSingleFile(widget.Url!);

      int home = WallpaperManager.HOME_SCREEN;
      int lock = WallpaperManager.LOCK_SCREEN;
      int both = WallpaperManager.BOTH_SCREEN;
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(),
              title: const Center(child: Text("Set Wallpaper as")),
              content: SizedBox(
                height: 200,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                                  file.path, home)
                              .then((value) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Wallpaper set successfully.",
                                gravity: ToastGravity.TOP);
                          });
                        },
                        child: const Text(
                          "HomeScreen",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                                  file.path, lock)
                              .then((value) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Wallpaper set successfully.",
                                gravity: ToastGravity.TOP);
                          });
                        },
                        child: const Text(
                          "LockScreen",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () async {
                          await WallpaperManager.setWallpaperFromFile(
                                  file.path, both)
                              .then((value) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                                msg: "Wallpaper set successfully.",
                                gravity: ToastGravity.TOP);
                          });
                        },
                        child: const Text(
                          "Both",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            );
            ;
          }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PhotoView(
            customSize:
                Size(double.infinity, MediaQuery.of(context).size.height / 1),
            imageProvider: NetworkImage(widget.Url!)),
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    setWallpaper();
                  },
                  icon: const Icon(
                    Icons.wallpaper_outlined,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {
                    downloadImage();
                  },
                  icon: const Icon(
                    Icons.download,
                    size: 40,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 40,
                  ))
            ],
          ),
        ),
      ],
    ));
  }
}
