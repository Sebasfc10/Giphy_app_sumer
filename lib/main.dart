import 'package:flutter/material.dart';
import 'package:giphy_app/BLOC/models/gif_model.dart';
import 'package:giphy_app/favButton.dart';

void main() {
  runApp(const MyApp());
  listadoGifs = getGifs(); //Trae los gif del EndPoint Trending, una disculpa no se como swichear la renderizacion de las dos listas que consumen los endpoints, trending y search, para completar la prueba priorice el de search, saludos.
  String? data;
  search(data);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

     String dataSearch = controller.text;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giphy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.only(right: 7, left: 7,
              top: 38, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                search(controller.text);
                                print(controller.text);
                               });
                            },
                            icon: Icon(Icons.search, color: Colors.black),
                          ),
                          hintText: "Empieza buscando un gif :D y pulsa la lupa",
                          contentPadding: EdgeInsets.all(8),
                          filled: true,
                          fillColor: Colors.indigo[50],
                          border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(14),
                           borderSide: BorderSide.none,
                            ),
                          ),
                      ),
                  ),
                ],
              ),
            ), 
              Expanded(
                child: FutureBuilder(
                  future: search(dataSearch),
                  //listadoGifs,
                  builder: (context, snapshot){
                      if(snapshot.hasData) {
                          return GridView.count(
                            crossAxisCount: 2,
                            children: listGifs(snapshot.data),
                          );
                            
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Expanded(
                          child: Center(child: Text(
                            "Data not found"
                          ),));
                      }
                      return 
                      Center(
                        child: CircularProgressIndicator(),
                      );
                      
                    },
                  ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listGifs(data) {
    List<Widget> gifs = [];

      for (var gif in data){
        gifs.add(
          Stack(
            children: [
              Card(child: Column(
            children: [
              Expanded(
                child: Image.network(
                  gif.url,
                  fit: BoxFit.fill,
                  width: 320,
                  height: 200,
                    )),
                ],
              )
            ),
              Positioned(
                right: 10,
                bottom: 10,
                child: FloatingActionButtonGreen(),
                ),
            ],
          )
        );
      }
      return gifs;
  }
}
