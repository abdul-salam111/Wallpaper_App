import 'package:flutter/material.dart';
import 'package:wallpaperapi/categories.dart';

class CategoriesList extends StatelessWidget {
  List<String> categories = [
    "https://cdn.pixabay.com/photo/2018/01/13/19/39/fashion-3080644_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/23/00/43/audio-1851517_1280.jpg",
    "https://cdn.pixabay.com/photo/2010/12/13/10/05/berries-2277_1280.jpg",
    "https://cdn.pixabay.com/photo/2018/01/17/07/06/laptop-3087585_1280.jpg",
    "https://cdn.pixabay.com/photo/2020/05/13/15/44/geometry-5167943_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/12/15/13/51/polynesia-3021072_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/01/28/23/10/mosque-615415_1280.jpg",
    "https://cdn.pixabay.com/photo/2013/10/02/23/03/mountains-190055_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/05/08/13/15/bird-2295431_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/03/27/18/31/book-1283468_1280.jpg",
    "https://cdn.pixabay.com/photo/2014/10/14/20/24/football-488714__480.jpg",
    "https://cdn.pixabay.com/photo/2017/11/03/12/10/dolomites-2914157_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/12/27/19/41/halloween-72939_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/02/20/18/03/cat-2083492_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/03/30/20/33/heart-700141_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_1280.jpg"
  ];
  List<String> CategoriesNames = [
    "Fashion",
    "Music",
    "Food",
    "Education",
    "Science",
    "Background",
    "Sea",
    "Masjid",
    "sky",
    "Animal",
    "Birds",
    "Islamic",
    "Sports",
    "Nature",
    "Hallowen",
    "Pets",
    "Love",
    "Flowers"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                print(CategoriesNames[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => CategoriesDetails(
                              categoryName: CategoriesNames[index],
                            )));
              },
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  opacity: 0.5,
                  image: NetworkImage(categories[index]),
                  fit: BoxFit.cover,
                )),
                child: Center(
                    child: Text(
                  CategoriesNames[index],
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
              ),
            );
          })),
    );
  }
}
