
import 'dart:math';
import 'dart:ui';
import 'package:caro_app/main.dart';
import 'package:caro_app/pages/home_page.dart';
import 'package:caro_app/pages/setting_page.dart';
import 'package:flutter/material.dart';
import '../app_assets.dart';
import '../app_colors.dart';
import '../SetUp.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayGamepageTwo extends StatefulWidget {
  const PlayGamepageTwo({Key? key}) : super(key: key);

  @override
  State<PlayGamepageTwo> createState() => _PlayGamepageState();
}

class _PlayGamepageState extends State<PlayGamepageTwo> {
  int _luot = 1;
  int ?_currentIndex;
  int ?_previousIndex;
  bool isEndGame = false;
  List<String> Avatar = [AppAssets.AvataBoy1, AppAssets.AvataBoy2, AppAssets.AvataGirl1, AppAssets.AvataGirl2];
  int indexAvataX = 0;
  int indexAvataO = 02;
  List<String> Board = [];
  int numXWin = 0;
  int numOWin = 0;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Board = MakeNullListSquare(Board);
    GetBoardSave();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 16, bottom: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                indexAvataX++;
                                if(indexAvataX > 3)
                                  indexAvataX = 0;
                              });
                            },
                            child: Container(
                              child: Image.asset(Avatar[indexAvataX]),
                              decoration: BoxDecoration(
                                border: _luot == 1 ? Border(
                                  top: BorderSide(color: AppColor.BlueMain, width: 4),
                                  bottom: BorderSide(color: AppColor.BlueMain, width: 4),
                                  left: BorderSide(color: AppColor.BlueMain, width: 4),
                                  right: BorderSide(color: AppColor.BlueMain, width: 4),
                                ) : null
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Image.asset(AppAssets.IconX),
                          ),
                          
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          child: Image.asset(AppAssets.iconVS),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, right: 16, bottom: 10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                indexAvataO++;
                                if(indexAvataO > 3)
                                  indexAvataO = 0;
                              });
                            },
                            child: Container(
                              child: Image.asset(Avatar[indexAvataO]),
                              decoration: BoxDecoration(
                                border: _luot == 2 ? Border(
                                  top: BorderSide(color: AppColor.BlueMain, width: 4),
                                  bottom: BorderSide(color: AppColor.BlueMain, width: 4),
                                  left: BorderSide(color: AppColor.BlueMain, width: 4),
                                  right: BorderSide(color: AppColor.BlueMain, width: 4),
                                ) : null
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Image.asset(AppAssets.IconO),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 16),
                      child: Row(
                        children: [
                          Image.asset(AppAssets.iconTroPhy),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(numXWin.toString(), 
                              style: TextStyle(color: AppColor.White, fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          numOWin = 0;
                          numXWin = 0;
                        });
                      },
                      child: Container(
                        child: Image.asset(AppAssets.iconReset),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 16),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            child: Text(numOWin.toString(), 
                              style: TextStyle(color: AppColor.White, fontSize: 24),
                            ),
                          ),
                          Image.asset(AppAssets.iconTroPhy),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height/25),
                  height: size.height / 2 + 10,
                  child: SetUpBoard() 
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          SoundPress();
                          NewGame();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height/15,
                          width: size.width/4,
                          child: Text('Ván Mới',
                            style: TextStyle(fontSize: 20, fontFamily: 'Lobster', color: AppColor.Black),
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
                          Undo();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height/15,
                          width: size.width/4,
                          child: Text('Đánh Lại',
                            style: TextStyle(fontSize: 20, fontFamily: 'Lobster', color: AppColor.Black),
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
                        onTap: () async {
                          SoundPress();
                          int count = 0;
                          for(int i = 0; i < 225; i++){
                            if(Board[i] == empty)
                              count++;
                          }
                          if(count == 225){
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('numOWin', numOWin);
                            await prefs.setInt('numXWin', numXWin);
                            Navigator.of(context).pop();
                          }
                          else DialogSaveBoard(context, Board);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height/15,
                          width: size.width/4,
                          child: Text('Thoát',
                            style: TextStyle(fontSize: 20, fontFamily: 'Lobster', color: AppColor.Black),
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
                      )
                    ],
                  ),
                )
              ],
            ),
             
           ],
        ),
      ),
    );
  }

  GridView SetUpBoard() {
    return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 15,
                  ),
                  itemCount: 225,
                  itemBuilder: (context, index){
                    return Container(
                      decoration: _currentIndex == index ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.BlueMain, width: 2),
                          top: BorderSide(color: AppColor.BlueMain, width: 2),
                          left: BorderSide(color: AppColor.BlueMain, width: 2),
                          right: BorderSide(color: AppColor.BlueMain, width: 2),
                        )
                      ): null,
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                              if(isEndGame == true){
                                return null;
                              }else{
                                if(Board[index] != empty){
                                return null;
                              }else{
                                if(_luot == 1){
                                  Board[index] = X;
                                  _previousIndex = _currentIndex;
                                  _currentIndex = index;
                                  showWin(index);
                                   _luot = 2;
                                }else{
                                  Board[index] = O;
                                   _previousIndex = _currentIndex;
                                   _currentIndex = index;
                                   showWin(index);
                                   _luot = 1;
                                }
                              }
                            }
                          });
                        },
                        child: getIconCaro(Board[index])
                      ),
                    );
                  }, 
                );
  }

  void showDiaLogWiner(int Win){
      if(isVolume == true){
        final sound = AudioPlayer();
      sound.setVolume(0.2);
      sound.play(AssetSource('mussic/Win_mp3.mp3'));
      }
      setState(() {
        isEndGame = true;
        if(Win != 0){
          if(Win == -1000)
            numXWin++;
          else numOWin++;
        }

      });
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SizedBox(
          height: size.height/4,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(AppAssets.Win),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 16),
                child: Win == 0 ? Text('Hòa', style: TextStyle(color: AppColor.White, fontSize: 30),)
                : Win == -1000 ? Text('X WIN', style: TextStyle(color: AppColor.White, fontSize: 30),)
                : Text('O WIN', style: TextStyle(color: AppColor.White, fontSize: 30),)
              )
            ],
          ),
        ),
      );
    });
  }

  void showWin(int index){
    if(CheckWiner(Board) == 0)
      showDiaLogWiner(0);
    else{
      if(CheckWiner(Board) == -1000)
        showDiaLogWiner(-1000);
      if(CheckWiner(Board) == 1000)
      showDiaLogWiner(1000);
    }
  }
  void Undo(){
    setState(() {
      if(_currentIndex != null &&  _currentIndex != _previousIndex){
        Board[_currentIndex!] = empty;
        _currentIndex = _previousIndex;
        if(_luot == 1){
        _luot = 2;
        } else _luot = 1;
      }
    });
  }

  void NewGame(){
    setState(() {
      MakeNullListSquare(Board);
      _luot = 1;
      _currentIndex = null;
      isEndGame = false;
    });
  }

  Future<void> GetBoardSave() async {
    final prefs = await SharedPreferences.getInstance();
    Board = prefs.getStringList('BoardTow') ?? MakeNullListSquare(Board);
    setState(() {
      SetUpBoard();
      numOWin = prefs.getInt('numOWinTwo') ?? 0;
      numXWin = prefs.getInt('numXWinTwo') ?? 0;
    });
  }

  void DialogSaveBoard(BuildContext context, List<String> Board){
  showDialog(context: context, builder: (BuildContext context){
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
      title: Text("Xác Nhận Thoát"),
      content: Text("Bạn Có Muốn Lưu Bàn Cờ"),
      actions: [
        ElevatedButton(
            child: Text("Yes"),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setStringList('BoardTow', Board);
              await prefs.setInt('numOWinTwo', numOWin);
              await prefs.setInt('numXWinTwo', numXWin);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
        ),
        ElevatedButton(
            child: Text("No"),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('BoardTow');
              await prefs.setInt('numOWin', numOWin);
              await prefs.setInt('numXWin', numXWin);
              Navigator.of(context).pop();
               Navigator.of(context).pop();
            }
        ),
      ],
    );
    });
}


}