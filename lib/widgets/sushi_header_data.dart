import 'package:flutter/material.dart';

class SushiHeaderData extends StatelessWidget {
  const SushiHeaderData({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Asiatisch .  koreanisch . Japnisch',
              style: TextStyle(fontSize: 14),
            ),
          SizedBox(height: 4,),
          Row(
            children: [
              Text("4.5", style: TextStyle(fontSize: 12.0),),
              SizedBox(width: 6.0,),
              Icon(Icons.star, size: 14.0,),
            ],
          )
        ],
      ),
    );

  }
}
