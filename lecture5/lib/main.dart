import 'package:flutter/material.dart';

class Student {
  String name;
  int age;

  Student(this.name, this.age);

  @override
  String toString() {
    return 'Student{name: $name, age: $age}';
  }
}

class StudentGroup {
  List<Student> _students = [];

  void addStudent(Student student) {
    _students.add(student);
  }

  void removeStudent(String name) {
    _students.removeWhere((student) => student.name == name);
  }

  List<Student> getStudentsByAge(int age) {
    return _students.where((student) => student.age == age).toList();
  }

  int get averageAge {
    if (_students.isEmpty) return 0;
    return (_students.map((student) => student.age).reduce((a, b) => a + b) / _students.length).round();
  }

  @override
  String toString() {
    return 'StudentGroup{students: $_students}';
  }
}

void main() {
  var group = StudentGroup();

  // Добавление студентов
  group.addStudent(Student('Alice', 20));
  group.addStudent(Student('Bob', 22));
  group.addStudent(Student('Charlie', 20));

  print(group); // Вывод содержимого группы студентов


  // Удаление студента
  group.removeStudent('Alice');
  print(group); // Проверка удаления студента

  // Получение студентов по возрасту
  var twentyYearOlds = group.getStudentsByAge(20);
  print(twentyYearOlds); // [Student{name: Charlie, age: 20}]

  // Средний возраст студентов в группе
  print('Average age: ${group.averageAge}'); // Средний возраст
}