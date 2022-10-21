import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapi/Modal/modals.dart';
import 'package:wallpaperapi/photoView.dart';

class CategoriesDetails extends StatefulWidget {
  String? categoryName;
  CategoriesDetails({Key? key, this.categoryName}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  List<Hits> wallpapers = [];
  var data;
  Future<List<Hits>> getCategoriesWallpaper() async {
    http.Response response = await http.get(Uri.parse(
        "https://pixabay.com/api/?key=30448284-931053eb23d75c729b26b4d5a&q=${widget.categoryName}&image_type=all&per_page=200&pretty=true"));
    data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data["hits"]) {
        wallpapers.add(Hits.fromJson(i));
      }

      return wallpapers;
    } else {
      return wallpapers;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.categoryName!), centerTitle: true),
        body: FutureBuilder(
          future: getCategoriesWallpaper(),
          builder: ((context, snapshot) {
            return snapshot != null
                ? GridView.builder(
                    reverse: false,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: wallpapers.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => PhotoViewScreen(
                                        Url: wallpapers[index].largeImageURL,
                                      )));
                        },
                        child: Container(
                          width: 150,
                          height: 260,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(wallpapers[index]
                                      .largeImageURL
                                      .toString()),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      );
                    })
                : Center();
          }),
        ));
  }
}
