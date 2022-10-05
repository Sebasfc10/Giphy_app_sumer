import 'dart:convert';

import 'package:http/http.dart' as http;

class Gif {
  String name;
  String url;

Gif(this.name, this.url);
}

 Future<List<Gif>> listadoGifs = getGifs();

 Future<List<Gif>> getGifs() async {
  final res = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/trending?api_key=2uMZ82THpzrfn1VofkJszp8SeucWWdqR&limit=25&rating=g"));

  List<Gif> gifs = [];

  if(res.statusCode == 200) {
    //codifica la data
    String body = utf8.decode(res.bodyBytes);

    final jsonData = jsonDecode(body);

    for (var item in jsonData["data"]){
      gifs.add(
        //Modelo de Datos
        Gif(item["title"], item["images"]["downsized"]["url"])
      );
    }

    return gifs;
  } else {
    throw Exception("Conexion interrumpida");
  }
}

Future<List<Gif>> search(String? _search) async{

    final http.Response response = await http.get(Uri.parse('https://api.giphy.com/v1/gifs/search?api_key=2uMZ82THpzrfn1VofkJszp8SeucWWdqR&limit=25&offset=&rating=g&lang=en&q=$_search'));

    List<Gif> gifs = [];

  if(response.statusCode == 200) {
    //codifica la data
    String body = utf8.decode(response.bodyBytes);

    final jsonData = jsonDecode(body);

    for (var item in jsonData["data"]){
      gifs.add(
        //Modelo de Datos
        Gif(item["title"], item["images"]["downsized"]["url"])
      );
    }

    return gifs;
  } else {
    throw Exception("Conexion interrumpida");
  }
  }