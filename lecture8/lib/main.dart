import 'package:flutter/material.dart';
import 'package:lecture8/album_model.dart';
import 'package:http/http.dart' as http; // Импортируем пакет http для выполнения HTTP-запросов.
import 'dart:convert'; // Импортируем пакет для работы с JSON.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Viewer',
      home: AlbumList(), // Устанавливаем AlbumList как домашнюю страницу.
    );
  }
}

class AlbumList extends StatefulWidget {
  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  late Future<List<Album>> futureAlbums; // Создаем Future, чтобы загрузить список альбомов.

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  // Метод для выполнения HTTP-запроса и получения списка альбомов.
  Future<List<Album>> fetchAlbums() async {
    // Выполняем GET-запрос к API.
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

    // Проверяем, был ли запрос успешным (статус 200).
    if (response.statusCode == 200) {
      // Парсим тело ответа в виде JSON.
      List<dynamic> responseData = jsonDecode(response.body);

      // Преобразуем JSON-данные в список объектов Album.
      List<Album> albums = responseData.map((data) => Album.fromJson(data)).toList();
      return albums; // Возвращаем список альбомов.
    } else {
      // Если произошла ошибка, выбрасываем исключение.
      throw Exception('Failed to load albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Viewer'), // Заголовок приложения.
      ),
      body: Center(
        child: FutureBuilder<List<Album>>(
          future: futureAlbums, // Устанавливаем future для построения UI.
          builder: (context, snapshot) {
            // Если данные успешно загружены.
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length, // Количество альбомов.
                itemBuilder: (context, index) {
                  // Создаем виджет для каждого альбома.
                  return ListTile(
                    title: Text(snapshot.data![index].title), // Заголовок альбома.
                    subtitle: Text('User ID: ${snapshot.data![index].userId}, Album ID: ${snapshot.data![index].id}'), // Подзаголовок с дополнительной информацией.
                  );
                },
              );
            } else if (snapshot.hasError) {
              // Если произошла ошибка, отображаем сообщение об ошибке.
              return Text("${snapshot.error}");
            }
            // Пока данные загружаются, отображаем индикатор загрузки.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
