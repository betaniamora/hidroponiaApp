import 'package:flutter/material.dart';

Widget appbar(String titulo){

return  AppBar(
        title:Text('$titulo'),
        backgroundColor: Color(0xFFf2f2f2).withOpacity(0.5),
        elevation: 0.5,
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      
    ),
        flexibleSpace:Container(
          decoration:BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF52bbbf),Color(0xFF259aca)]),
          borderRadius: BorderRadius.circular(30),
          ),
          
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications) , onPressed: (){},iconSize: 25.0,)
        ],
        
      );

}