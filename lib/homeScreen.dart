import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallpaperapi/latest.dart';
import 'package:wallpaperapi/popular.dart';

import 'categoriesList.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 33, 32, 32),
          elevation: 0,
          child: ListView(
            children: const [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 33, 32, 32)),
                child: UserAccountsDrawerHeader(
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/a/ALm5wu1J6gOhaijiqSP45JkpSxbidkvMzlgxipDrLjrJeQ=s389-p-rw-no"),
                  ),
                  accountName: Text(
                    "AbdulSalam",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text("abdulsalam.0302@gmail.com"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.call),
                title: Text("+923115308116"),
              ),
              ListTile(
                leading: Icon(Icons.facebook),
                title: Text("Abdul Salam"),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.instagram),
                title: Text("sallo_bangash"),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.linkedin),
                title: Text("Abdul Salam"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("PixaBay"),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "CATEGORIES",
              ),
              Tab(
                text: "LATEST",
              ),
              Tab(
                text: "POPULAR",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoriesList(),
            const LatestCollection(),
            const Popular(),
          ],
        ),
      ),
    );
  }
}
