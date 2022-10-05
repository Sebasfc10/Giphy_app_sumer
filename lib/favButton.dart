import 'package:flutter/material.dart';

class FloatingActionButtonGreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FloatingActionButtonGreen();
  }

}

class _FloatingActionButtonGreen extends State<FloatingActionButtonGreen>{

  bool _active = false;

  void onPressedFav(){
    setState(() {
      _active = !this._active;
    });
    Scaffold.of(context).showSnackBar(
          SnackBar(
            content: this._active ? Text("Agregaste a tus favoritos") : Text("Quitaste de tus favoritos"),
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      backgroundColor: Colors.red[400],
      mini: true,
      tooltip: "Fav",
      onPressed: onPressedFav,
      child: Icon(
        this._active ? Icons.favorite : Icons.favorite_border,
      ),
    );
  }
  
}