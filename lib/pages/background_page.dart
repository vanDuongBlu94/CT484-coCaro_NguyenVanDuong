import 'package:caro_app/app_assets.dart';
import 'package:caro_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackGroundPage extends StatefulWidget {
  const BackGroundPage({Key? key}) : super(key: key);

  @override
  State<BackGroundPage> createState() => _BackGroundPageState();
}

class _BackGroundPageState extends State<BackGroundPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(context, 
          MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(AppAssets.logo),
      ),
    );
  }
}