import 'package:flutter/material.dart';
import 'package:matrix_16_16/dialog_hex_str.dart';
import 'package:window_manager/window_manager.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
      size: Size(900, 900),
      center: true,
      backgroundColor: Colors.black,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal);
  windowManager.waitUntilReadyToShow(windowOptions, ()async{
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MaterialApp(home: Matrix(),));
}

class Matrix extends StatefulWidget {
  const Matrix({super.key});

  @override
  State<Matrix> createState() => _MatrixState();
}

class _MatrixState extends State<Matrix> {
  final List<Color> _ledColor = List.generate(256, (index) => Colors.blueGrey);
  @override
  Widget build(BuildContext context) {
    var matrixBuilder = Expanded(
      flex: 8,
        child: GridView.builder(
            padding: const EdgeInsets.all(35),
            itemCount: _ledColor.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 16,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (BuildContext context, int index){
              return GestureDetector(
                  onTap: (){
                    if(_ledColor[index] == Colors.blueGrey){
                      _ledColor[index] = Colors.deepOrange;
                    } else {
                      _ledColor[index] = Colors.blueGrey;
                    }
                    //debugPrint("$index");
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: _ledColor[index],
                        borderRadius: BorderRadius.circular(100)),
                  )
              );
            })
    );

    var btnReset = GestureDetector(
      onTap: (){
        debugPrint("reset");
        for(int i = 0;i<_ledColor.length;i++){
          _ledColor[i] = Colors.blueGrey;
        }
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(top: 20, right: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Text(
            "清空",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 16),
        ),
      ),
    );

    var btnGenerate = GestureDetector(
      onTap: (){
        int start = 0;
        int end = 7;
        String binaryStr = '';
        List<int> matrix = [];
        while(end<=255){
          for(int i = start;i<=end;i++){
            if(_ledColor[i] == Colors.deepOrange){
              binaryStr = "${binaryStr}1";
            }else{
              binaryStr = "${binaryStr}0";
            }
          }
          matrix.add(int.parse(binaryStr, radix: 2));
          binaryStr = '';
          start += 8;
          end += 8;
        }
        //debugPrint('matrix length = ${matrix.length}');
        String matrixStr = '';
        for(var i in matrix){
          matrixStr = "${matrixStr}0x${i.toRadixString(16)},";
        }
        matrixStr = matrixStr.substring(0, matrixStr.lastIndexOf(','));
        //debugPrint(matrixStr);
        showDialog(
            context: context,
            builder: (_) => DialogHexStr(hexStr: matrixStr)
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(top: 20, right: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: const Text(
          "生成",
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 16),),
      ),
    );

    var controlBtn = Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[btnReset, btnGenerate],
        )
    );

    return MaterialApp(
      home: SafeArea(
        top: true,bottom: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[matrixBuilder, controlBtn],
        ),
      ),
    );
  }
}

