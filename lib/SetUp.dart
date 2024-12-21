import 'package:caro_app/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/home_page.dart';
import 'app_assets.dart';
import 'app_colors.dart';
import '../pages/play_game_page_one.dart';
import '../pages/play_game_page_two.dart';

  dynamic CheckWiner(List Board) {
      List<int> indexWin = [];
      // check ngang
      for(int i = 0; i < 210; i+=15){
        for(int j = i; j <= i+10; j++){
            if(Board[j] == Board[j+1] && 
            Board[j] == Board[j+2] && 
            Board[j] == Board[j+3] && 
            Board[j] == Board[j+4] && 
            Board[j] != empty){
                if(Board[j] == X || Board[j] == XWIN){
                  for(int k = 0; k < 5; k++){
                    Board[j] =XWIN;
                    j++;
                  }
                  return -1000;
                }else{
                    for(int k = 0; k < 5; k++){
                      Board[j] = OWIN;
                      j++;
                    }
                    return 1000;
                } 
            }
        }
      }

      //check hang doc
      for(int i = 0; i <= 14; i++){
        for(int j = i; j <= i + 150; j+=15){
            if(Board[j] == Board[j+15] &&
              Board[j] == Board[j+30] &&
              Board[j] == Board[j+45] && 
              Board[j] == Board[j+60] && 
              Board[j] != empty)
            {
              if(Board[j] == X || Board[j] == XWIN){
                for(int k = 0; k < 5; k++){
                  Board[j] = XWIN;
                  j+=15;
                }
                return -1000;
              }else{
                for(int k = 0; k < 5; k++){
                  Board[j] = OWIN;
                  j+=15;
                }
                return 1000;
              } 
            }
        }
      }
  //check chéo 1
    // chéo trên
    for(int i = 4; i <= 14; i++){
      int count = 0;
      int position = i;
      indexWin.clear();
      for(int j = 0; j < i; j++){
        if(Board[position] == Board[position+14] && Board[position] != empty){
          count++;
          indexWin.add(position);
        }else count = 0;
        position += 14;
        if(count >= 4){
          if(Board[position] == X || Board[position] == XWIN){
            for(int k = 0; k < 5; k++){
              indexWin.add(position);
              Board[indexWin[k]] = XWIN;
            }
            return -1000;
          }
          else {
            indexWin.add(position);
            for(int k = 0; k < 5; k++){
              Board[indexWin[k]] = OWIN;
            }
            return 1000;
          }
        }
      }
    }
    //chéo dưới
    int N = 13;
    for(int i = 29; i <= 164; i+= 15){
      int count = 0;
      int position = i;
      indexWin.clear();
      for(int j = 0; j < N; j++){
        if(Board[position] == Board[position+14] && Board[position] != empty){
          count++;
          indexWin.add(position);
        }else count = 0;
        position += 14;
        if(count >= 4){
        if(Board[position] == X || Board[position] == XWIN){
          indexWin.add(position);
          for(int k = 0; k < 5; k++){
              Board[indexWin[k]] = XWIN;
          }
          return -1000;
        }
        else {
          indexWin.add(position);
          for(int k = 0; k < 5; k++){
              Board[indexWin[k]] = OWIN;
          }
          return 1000;
        } 
      }
      }
      N--;
    }

  //check chéo 2
    // chéo trên
    int M = 14;
    for(int i = 0; i <= 150; i+= 15){
      int count = 0;
      int position = i;
      indexWin.clear();
      for(int j = 0; j < M; j++){
        if(Board[position] == Board[position+16] && Board[position] != empty){
          count++;
          indexWin.add(position);
        }else count = 0;
        position += 16;
        if(count >= 4){
        if(Board[position] == X || Board[position] == XWIN){
          indexWin.add(position);
          for(int k = 0; k < 5; k++){
              Board[indexWin[k]] = XWIN;
          }
          return -1000;
        }
        else{
          indexWin.add(position);
          for(int k = 0; k < 5; k++){
              Board[indexWin[k]] = OWIN;
          }
          return 1000;
        } 
      }
      }
      M--;
    }
    //chéo dưới
    int K = 14;
    for(int i = 0; i <= 10; i++){
      int count = 0;
      int position = i;
      indexWin.clear();
      for(int j = 0; j < K; j++){
        if(Board[position] == Board[position + 16] && Board[position] != empty){
          count++;
          indexWin.add(position);
        }else count = 0;
        position += 16;
        if(count >= 4){
          if(Board[position] == X || Board[position] == XWIN){
            indexWin.add(position);
            for(int k = 0; k < 5; k++){
                Board[indexWin[k]] = XWIN;
            }
            return -1000;
          }
          else{
            indexWin.add(position);
            for(int k = 0; k < 5; k++){
                Board[indexWin[k]] = OWIN;
            }
            return 1000;
          } 
        }
      }
      K--;
    }
    
    int Tie = 0;
    for(int i = 0; i < 225; i++){
      if(Board[i] != empty)
        Tie++;
    }
    if(Tie == 225)
      return 0;
    
  }

final String X = 'X';
final String O = 'O';
final String empty = '';
final String XWIN = 'XWIN';
final String OWIN = 'OWIN';

List<String> MakeNullListSquare(List<String> Board){
  Board.clear();
  for(int i = 0; i < 225 ; i++){
    Board.add(empty);
  }
  return Board;
}

Container getIconCaro(String state){
  switch(state){
    case 'X': {
      return Container(
        height: 30,
        width: 30,
        decoration:  BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1)
        ),
        child: Image.asset(AppAssets.IconX),      
      );
    }
    case 'O': {
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1)
        ),
        child: Image.asset(AppAssets.IconO),
      );
    }
    case '': {
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1)
        ),
      );
    }
    case 'XWIN':{
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.white, width: 1)
        ),
        child: Image.asset(AppAssets.IconX) 
      );
    }
     case 'OWIN':{
      return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.white, width: 1)
        ),
        child: Image.asset(AppAssets.IconO) 
      );
    }
  }
  return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 1)
        ),
      );
}

void SoundPress(){
  if(isVolume == true){
    final sound = AudioPlayer();
    sound.setVolume(0.2);
    sound.play(AssetSource('mussic/press_mp3.mp3'));
  } 
}




  