import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa/types/recipe.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

Future<Album> fetchAlbum(int albumId) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$albumId'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class _RecipeListState extends State<RecipeList> {
  final _suggestions = <Album>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(1);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Album>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Text(snapshot.data!.title);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default return a loading indicator
          return const CircularProgressIndicator();
        });
  }
}
