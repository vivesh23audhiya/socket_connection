import 'package:flutter/material.dart';


class PickerUI extends StatelessWidget {
  final Function(String) onTab;
  const PickerUI({super.key, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.blue,
      width: 150,
      height: 150,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              onTab.call("Camera");
            },
            child: const ListTile(title: Text('Camera',
              style: TextStyle(color: Colors.white),)),
          ),
          GestureDetector(
            onTap: (){
              onTab.call("Gallery");
            },
            child: const ListTile(title: Text('Gallery',
              style: TextStyle(color: Colors.white),)),
          )
        ],
      ),

    );
  }
}
