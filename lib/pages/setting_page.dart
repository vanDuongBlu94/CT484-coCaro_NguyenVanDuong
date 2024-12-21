// import 'package:caro_app/models/app_colors.dart';
// import 'package:flutter/material.dart';

// import '../models/app_assets.dart';

//    bool isVolume = true;
//    bool isMusic = true;

// class SettingPage extends StatefulWidget {
//   const SettingPage({Key? key}) : super(key: key);

//   @override
//   State<SettingPage> createState() => _SettingPageState();
// }

// class _SettingPageState extends State<SettingPage> {
//   int indexlever = 1;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Container(
//             child: Image.asset(AppAssets.Background, 
//               fit: BoxFit.cover,
//               height: size.height,
//               width: size.width,
//             ),
//           ),
//           GestureDetector(
//             onTap: (){
//               Navigator.pop(context);
//             },
//             child: Container(
//               margin: EdgeInsets.only(top: 70, left: 20),
//               child: Image.asset(AppAssets.IconBack, color: Colors.blue,),
//             ),
//           ),
//           Center(
//             child: Container(
//               child: Image.asset(AppAssets.BackgroundSetting,fit: BoxFit.fill, height: size.height* 2/3,),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
              
//               Container(
//                 margin: EdgeInsets.only(top: size.height * 3/7, left: 30, right: 30),
//                 child: Text('Độ khó Chơi Với May', 
//                   style: TextStyle(color: Colors.white, fontSize: 24, fontFamily: 'Lobster'),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 16, left: 30, right: 30),
//                 height: size.height/16,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: (){
//                           setState(() {
//                             indexlever = 1;
//                           });
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text('1', 
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: indexlever == 1 ? Colors.blue : Colors.transparent
//                           ),
//                         ),
//                       )
//                     ),
//                      Expanded(
//                       child: GestureDetector(
//                         onTap: (){
//                           setState(() {
//                             indexlever = 2;
//                           });
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text('2', 
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: indexlever == 2 ? Colors.blue : Colors.transparent
//                           ),
//                         ),
//                       )
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: (){
//                           setState(() {
//                             indexlever = 3;
//                           });
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text('3', 
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: indexlever == 3 ? Colors.blue : Colors.transparent
//                           ),
//                         ),
//                       )
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: (){
//                           setState(() {
//                             indexlever = 4;
//                           });
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           child: Text('4', 
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: indexlever == 4 ? Colors.blue : Colors.transparent
//                           ),
//                         ),
//                       )
//                     ),
//                   ],
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border(
//                     bottom: BorderSide(color: Colors.blue, width: 3),
//                     top: BorderSide(color: Colors.blue, width: 3),
//                     left: BorderSide(color: Colors.blue, width: 3),
//                     right: BorderSide(color: Colors.blue, width: 3),
//                   )
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             setState(() {
//                               isVolume = !isVolume;
//                             });
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             child: isVolume ? Image.asset(AppAssets.iconVolume) : Image.asset(AppAssets.iconMute),
//                             decoration: BoxDecoration(
//                               color: AppColor.BlueMain,
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Text('Âm Thanh',
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         GestureDetector(
//                           onTap: (){
//                             setState(() {
//                               isMusic = !isMusic;
//                             });
//                           },
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             child: isMusic ? Image.asset(AppAssets.iconNote) : Image.asset(AppAssets.iconMuteNote),
//                             decoration: BoxDecoration(
//                               color: AppColor.BlueMain,
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Text('Nhạc Nền',
//                             style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Lobster', fontWeight: FontWeight.bold),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           )
//         ],
//       )
//     );
//   }
// }