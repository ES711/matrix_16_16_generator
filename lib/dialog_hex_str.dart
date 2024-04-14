import 'package:flutter/material.dart';

class DialogHexStr extends StatelessWidget {
  final String hexStr;
  const DialogHexStr({super.key, required this.hexStr});
  @override
  Widget build(BuildContext context) {
    var btnDialogCancel = GestureDetector(
      onTap: (){
        Navigator.of(context).pop();
      },
      child: Container(
        height: 60,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 50, left: 80, right: 80),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20)),
        child: const Text(
          "關閉",
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 16,
              color: Colors.black),
        ),
      ),
    );


    var dialogMatrix = Container(
      margin: const EdgeInsets.only(top: 200, bottom: 200, left: 100, right: 100),
      padding: const EdgeInsets.only(left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            textAlign: TextAlign.justify,
            hexStr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              decoration: TextDecoration.none,)
          ),
          btnDialogCancel],
      )
    );

    return dialogMatrix;
  }
}
