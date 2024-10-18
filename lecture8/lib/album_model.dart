class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    // Параметр обязателен и должен быть передан при создании объекта
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {    // Фабричный метод для создания объекта Album из Map, содержащего данные JSON
    return Album(
      // Получаем значение из Map и присваиваем его свойству объекта
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}