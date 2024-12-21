
import 'dart:math';
import 'package:caro_app/main.dart';
import 'package:caro_app/pages/home_page.dart';
import 'package:caro_app/pages/setting_page.dart';
import 'package:flutter/material.dart';
import '../SetUp.dart';
import '../app_assets.dart';
import '../app_colors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayGamepageOne extends StatefulWidget {
  const PlayGamepageOne({Key? key}) : super(key: key);

  @override
  State<PlayGamepageOne> createState() => _PlayGamepageState();
}

class _PlayGamepageState extends State<PlayGamepageOne> {
  int _luot = 1;
  int ?_currentIndex;
  int ?_previousIndex;
  int ?_currentIndexCom;
  int ?_previousIndexCom;
  int ?_currentIndexHuman;
  int ?_previousIndexHuman;
  bool isEndGame = false;
  List<String> Board = [];
  List<String> Avatar = [AppAssets.AvataBoy1, AppAssets.AvataBoy2, AppAssets.AvataGirl1, AppAssets.AvataGirl2];
  int indexAvataX = 0;
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
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Image.asset(AppAssets.iconVS),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, right: 16, bottom: 10),
                        child: Column(
                          children: [
                            Container(
                              child: Image.asset(AppAssets.AvataRobot),
                              decoration: BoxDecoration(
                                border: _luot == 2 ? Border(
                                  top: BorderSide(color: AppColor.BlueMain, width: 4),
                                  bottom: BorderSide(color: AppColor.BlueMain, width: 4),
                                  left: BorderSide(color: AppColor.BlueMain, width: 4),
                                  right: BorderSide(color: AppColor.BlueMain, width: 4),
                                ) : null
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: Image.asset(AppAssets.IconO),
                            )
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
                  margin: EdgeInsets.only(top: size.height/25, bottom: 16),
                  height: size.height / 2 + 10,
                  child: SetUpBoard() 
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                        onTap: (){
                          SoundPress();
                          int count = 0;
                          for(int i = 0; i < 225; i++){
                            if(Board[i] == empty)
                              count++;
                          }
                          if(count == 225)
                            Navigator.of(context).pop();
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
                      decoration: _currentIndex == index  ? BoxDecoration(
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
                                  _previousIndexHuman = _currentIndexHuman;
                                  _currentIndexHuman = index;
                                   _previousIndex =_currentIndex;
                                  _currentIndex = index;
                                  _luot = 2;
                                  showWin(index);
                                  playChess();
                                  showWin(index);
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

  void NewGame(){
    setState(() {
      MakeNullListSquare(Board);
      _luot = 1;
      _currentIndexHuman = null;
      _currentIndexCom = null;
      _currentIndex = null;
      isEndGame = false;
    });
  }

  void showDiaLogWiner(int Win){
    setState(() {
      isEndGame = true;
      if(isVolume == true){
        final sound = AudioPlayer();
        sound.setVolume(0.2);
        if(Win == -1000 || Win == 0){
          sound.play(AssetSource('mussic/Win_mp3.mp3'));
          numXWin++;
        }
        else {
          sound.play(AssetSource('mussic/Loss_mp3.mp3'));
          numOWin++;
        }
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      Size size = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SizedBox(
          height: size.height/4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(AppAssets.Win),
              ),
              Container(
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
      if(_currentIndexHuman != null &&  _currentIndexHuman != _previousIndexHuman && _currentIndexCom != _previousIndexCom){
        Board[_currentIndexHuman!] = empty;
        Board[_currentIndexCom!] = empty;
        _currentIndexHuman = _previousIndexHuman;
        _currentIndexCom = _previousIndexCom;
        _luot = 1;
      }
    });
  }

  Future<void> GetBoardSave() async {
    final prefs = await SharedPreferences.getInstance();
    Board = prefs.getStringList('BoardOne') ?? MakeNullListSquare(Board);
    setState(() {
      SetUpBoard();
      numOWin = prefs.getInt('numOWinOne') ?? 0;
      numXWin = prefs.getInt('numXWinOne') ?? 0;
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
              await prefs.setStringList('BoardOne', Board);
              await prefs.setInt('numOWinOne', numOWin);
              await prefs.setInt('numXWinOne', numXWin);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
        ),
        ElevatedButton(
            child: Text("No"),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('BoardTow');
              await prefs.setInt('numOWinOne', numOWin);
              await prefs.setInt('numXWinOne', numXWin);
              Navigator.of(context).pop();
               Navigator.of(context).pop();
            }
        ),
      ],
    );
    });
}


List<int> MangDiemTanCong = [ 0, 9, 54, 162, 1458, 13112, 118008 ]; 
List<int> MangDiemPhongNgu = [0, 3, 27, 99, 729, 6561, 59049];

void playChess(){
   int move = BestMove();
  setState(() {
    if(move != null && isEndGame == false){
      Board[move] = O;          
      _luot = 1;
      _previousIndex = _currentIndex;
      _currentIndex = move;
      _previousIndexCom = _currentIndexCom;
      _currentIndexCom = move;
    }
  });
}

int BestMove(){
  int BestMove = 0;
  int DiemMax = 0;
  for(int i = 0; i < 225; i++){
    if(Board[i] == empty){
      int DiemTanCong = DiemTC_DuyetDoc(i) + DiemTC_DuyetNgang(i) + DiemTC_DuyetCheoXuoi(i) + DiemTC_DuyetCheoNguoc(i);
      int DiemPhongNgu = DiemPN_DuyetDoc(i) + DiemPN_DuyetNgang(i) + DiemPN_DuyetCheoXuoi(i) + DiemPN_DuyetCheoNguoc(i);
      int DiemTam = DiemTanCong > DiemPhongNgu ? DiemTanCong : DiemPhongNgu;
      if(DiemMax < DiemTam){
        DiemMax = DiemTam;
        BestMove = i;
      }
    }
  }
  return BestMove;
}

int DiemTC_DuyetDoc(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 15;
  for(int i = 1; i < 6  ; i++){
    if(currentIndex < 0){
      break;
    }else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else {
          break;
        }
      }
      currentIndex -= 15;
    }
    
  }

  currentIndex = index + 15;
  for(int i = 1; i < 6; i++){
    if(currentIndex > 224)
       break;
    else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else {
          break;
        }
      }
    }
    currentIndex += 15;
  }
  if(human == 2) {
    return 0;
  }

  DiemTong -= MangDiemPhongNgu[human] * 2;
  DiemTong += MangDiemTanCong[computer];
  return DiemTong;
}

int DiemTC_DuyetNgang(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 1;
  for(int i = 1; i < 6; i++){
    if(currentIndex < 0 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194
        || currentIndex == 209 || currentIndex == 224 ) {
      break;
    } else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else {
          break;
        }
      }
    }
    currentIndex--;
    
  }

  currentIndex = index + 1;
  for(int i = 1; i < 6; i++){
    if(currentIndex == 15 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 || currentIndex > 224) {
      break;
    } else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else break;
      }
    }
    currentIndex++;
  }
  if(human == 2)
    return 0;
  DiemTong -= MangDiemPhongNgu[human] * 2;
  DiemTong += MangDiemTanCong[computer];
  return DiemTong;
}

int DiemTC_DuyetCheoXuoi(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 16;
  for(int i = 1; i < 6; i++){
    if( currentIndex < 0 || currentIndex == 0 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194 )
             break;
    else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else break;
      }
    }
    currentIndex -= 16;
    
  }

  currentIndex = index + 16;
  for(int i = 1; i < 6; i++){
   if(currentIndex  > 224 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 )
             break;
    else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else break;
      }
    }
    currentIndex += 16;
  }
  if(human == 2)
    return 0;
  DiemTong -= MangDiemPhongNgu[human] * 2;
  DiemTong += MangDiemTanCong[computer];
  return DiemTong;
}

int DiemTC_DuyetCheoNguoc(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 14;
  for(int i = 1; i < 6; i++){
     if(currentIndex  < 0 || currentIndex == 0 || currentIndex == 15 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 )
             break;
    else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else break;
      }
    }
    currentIndex -= 14;   
  }

  currentIndex = index + 14;
  for(int i = 1; i < 6; i++){
     if( currentIndex > 224 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194
        || currentIndex == 209 || currentIndex == 224 )
             break;
    else{
      if(Board[currentIndex] == O)
        computer++;
      else{
        if(Board[currentIndex] == X){
          human++;
          break;
        }else break;
      }
    }
      currentIndex += 14;
  }
  if(human == 2)
    return 0;
  DiemTong -= MangDiemPhongNgu[human] * 2;
  DiemTong += MangDiemTanCong[computer];
  return DiemTong;
}


int DiemPN_DuyetDoc(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 15;
  for(int i = 1; i < 6  ; i++){
    if(currentIndex < 0){
      break;
    }else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
      currentIndex -= 15;
    }
    
  }

  currentIndex = index + 15;
  for(int i = 1; i < 6; i++){
    if(currentIndex > 224)
       break;
    else{
       if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex += 15;
  }
  if(computer == 2)
    return 0;

  DiemTong += MangDiemPhongNgu[human];
  return DiemTong;
}

int DiemPN_DuyetNgang(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 1;
  for(int i = 1; i < 6; i++){
    if(currentIndex < 0 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194
        || currentIndex == 209 || currentIndex == 224 )
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex--;
    
  }

  currentIndex = index + 1;
  for(int i = 1; i < 6; i++){
    if(currentIndex == 15 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 || currentIndex > 224)
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex++;
  }
  if(computer == 2)
    return 0;

  DiemTong += MangDiemPhongNgu[human];
  return DiemTong;
}

int DiemPN_DuyetCheoXuoi(int index){
  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 16;
  for(int i = 1; i < 6; i++){
    if( currentIndex < 0 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194 )
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex -= 16;
    
  }

  currentIndex = index + 16;
  for(int i = 1; i < 6; i++){
   if(currentIndex  > 224 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 )
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex += 16;
  }
  if(computer == 2)
    return 0;

  DiemTong += MangDiemPhongNgu[human];
  return DiemTong;
}

int DiemPN_DuyetCheoNguoc(int index){

  int DiemTong = 0;
  int computer = 0;
  int human = 0;
  int currentIndex = index - 14;
  for(int i = 1; i < 6; i++){
     if(currentIndex  < 0 || currentIndex == 0 || currentIndex == 15 || currentIndex == 30 || currentIndex == 45 || currentIndex == 60 || currentIndex == 75 || currentIndex == 90
      || currentIndex == 105 || currentIndex == 120 || currentIndex == 135 || currentIndex == 150 || currentIndex == 165 || currentIndex == 180
      || currentIndex == 195 || currentIndex == 210 )
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
    currentIndex -= 14;   
  }

  currentIndex = index + 14;
  for(int i = 1; i < 6; i++){
     if( currentIndex > 224 || currentIndex == 14 || currentIndex == 29 || currentIndex == 44 || currentIndex == 59 || currentIndex == 74 || currentIndex == 89 || currentIndex == 104
        || currentIndex == 119 || currentIndex == 134 || currentIndex == 149 || currentIndex == 164 || currentIndex == 179 || currentIndex == 194
        || currentIndex == 209 || currentIndex == 224 )
             break;
    else{
      if(Board[currentIndex] == O){
        computer++;
        break;
      } 
      else{
        if(Board[currentIndex] == X){
          human++;
        }else break;
      }
    }
      currentIndex += 14;
  }
  if(computer == 2)
    return 0;

  DiemTong += MangDiemPhongNgu[human];
  return DiemTong;
}

}