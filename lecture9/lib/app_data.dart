import 'package:flutter/material.dart';

// Класс для хранения данных приложения, в данном случае только цвета фона
class AppData {
  Color backgroundColor;

  AppData({required this.backgroundColor});
// Метод для изменения цвета фона
  void changeBackgroundColor(Color newColor) {
    backgroundColor = newColor;
  }
}
// Класс, предоставляющий данные приложения через наследуемый виджет
class AppDataProvider extends InheritedWidget {
  const AppDataProvider({
    required this.appData,
    required super.child,
    super.key,
  });

  final AppData appData;

  // Метод для доступа к экземпляру AppDataProvider из дочерних виджетов
  static AppDataProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppDataProvider>();

  // Метод для сообщения фреймворку о необходимости обновления виджетов, когда данные изменяются
  @override
  bool updateShouldNotify(AppDataProvider oldWidget) {
    return true; // Всегда возвращаем true для обновления
  }
}
