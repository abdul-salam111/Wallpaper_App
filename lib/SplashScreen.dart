import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool tryagain = false;
  void checkInternet(
    context,
    String path,
  ) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, path);
      });
    } else {
      setState(() {
        tryagain = true;
      });
      Fluttertoast.showToast(msg: "No internet found");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternet(context, "homeScreen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Powered by"),
            Text(
              "PixaBay",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            tryagain
                ? TextButton(
                    onPressed: () {
                      checkInternet(context, "homeScreen");
                    },
                    child: Text("Try Again"))
                : Text("")
          ],
        ),
      ),
    );
  }
}
