// ignore_for_file: deprecated_member_use

import 'package:caro_app/SetUp.dart';
import 'package:caro_app/app_assets.dart';
import 'package:caro_app/app_colors.dart';
import 'package:caro_app/pages/play_game_page_one.dart';
import 'package:caro_app/pages/play_game_page_two.dart';
import 'package:caro_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

bool isVolume = true;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.BlueMain,
        onPressed: (){
          setState(() {
            isVolume = !isVolume;
          });
        },
        child: isVolume == true ? Image.asset(AppAssets.iconVolume) : Image.asset(AppAssets.iconMute),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.asset(
              AppAssets.Background,
              height: size.height,
              width: size.width,
              fit: BoxFit.cover,
              ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Image.asset(AppAssets.logoPng),
              ),
              GestureDetector(
                onTap: (){
                  SoundPress();
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => PlayGamepageOne())
                  );
                },
                child: Container(
                    height: size.height/12,
                    width: size.width *2/4,
                    margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: Text('Chơi Với Máy',
                      style: TextStyle(fontSize: 25, fontFamily: 'Lobster', color: AppColor.Black),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.BlueMain,
                      borderRadius: BorderRadius.circular(25),
                      border: Border(
                        bottom: BorderSide(color: AppColor.White, width: 3),
                        top: BorderSide(color: AppColor.White, width: 3),
                        left: BorderSide(color: AppColor.White, width: 3),
                        right: BorderSide(color: AppColor.White, width: 3),
                      )
                    ),
                ),
                
              ),
              GestureDetector(
                onTap: (){
                  SoundPress();
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => PlayGamepageTwo())
                  );
                },
                child: Container(
                    height: size.height/12,
                    width: size.width *2/4,
                    margin: EdgeInsets.only(top: 40),
                    alignment: Alignment.center,
                    child: Text('2 Người Chơi',
                      style: TextStyle(fontSize: 25, fontFamily: 'Lobster', color: AppColor.Black),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.BlueMain,
                      borderRadius: BorderRadius.circular(25),
                      border: Border(
                        bottom: BorderSide(color: AppColor.White, width: 3),
                        top: BorderSide(color: AppColor.White, width: 3),
                        left: BorderSide(color: AppColor.White, width: 3),
                        right: BorderSide(color: AppColor.White, width: 3),
                      )
                    ),
                ),
                
              ),
            ],
          ),
        ],
      ),
    );
  }
}
