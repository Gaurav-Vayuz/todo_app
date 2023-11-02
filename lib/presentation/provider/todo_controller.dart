import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/data/repo/db_helper.dart';

class TodoController with ChangeNotifier {
  bool isLoading = true;

  setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> todoList = [];
  List<TodoModel> _allTodoList = [];
  List<TodoModel> get allTodoList => _allTodoList;
  String searchQuery = "";

  getList() async {
    try {
      _allTodoList = [];
      final data = await DatabaseHandler().retrieveTodos();
      log("todo list $data");
      todoList = data;
      for (int i = 0; i < todoList.length; i++) {
        if (todoList
            .elementAt(i)['title']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase())) {
          _allTodoList.add(TodoModel(
              todoList.elementAt(i)["id"],
              todoList.elementAt(i)["title"],
              todoList.elementAt(i)["description"],
              todoList.elementAt(i)["date"]));
        }
        log("added list $_allTodoList");
      }
      _breakDownDateWise(_allTodoList);
    } catch (e) {
      _allTodoList = [];
    }
    log("list is $_allTodoList");
    setLoading(false);
  }

  editTodo(int id, String title, String desc, String date) async {
    final data = await DatabaseHandler().editTodo(id, title, desc, date);
    log("todo list $data");

    notifyListeners();
  }

  final dbHandler = DatabaseHandler();
  dynamic loadMessages() async {
    // await dbHandler.retrieveTodos(tableName);
    notifyListeners();
  }

  Future<void> removeItem(int id) async {
    await DatabaseHandler().deleteTodo(id);
    notifyListeners();
  }

  Future<void> addTodo(String title, String desc, String date) async {
    setLoading(true);
    final data = await DatabaseHandler.createItem(title, desc, date);
    log(data.toString());
    setLoading(false);
  }

  List<TodoModel> _todayList = [];
  List<TodoModel> get todayList => _todayList;

  List<TodoModel> _tomorrowList = [];
  List<TodoModel> get tomorrowList => _tomorrowList;

  List<TodoModel> _upcomingList = [];
  List<TodoModel> get upcomingList => _upcomingList;

  void _breakDownDateWise(List<TodoModel> todoList) {
    _todayList = [];
    _tomorrowList = [];
    _upcomingList = [];
    var date = DateTime.now();
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i].date ==
          DateTime(date.year, date.month, date.day).toString()) {
        _todayList.add(todoList.elementAt(i));
      } else if (todoList[i].date ==
          DateTime(date.year, date.month, date.day + 1).toString()) {
        tomorrowList.add(todoList.elementAt(i));
      } else {
        upcomingList.add(todoList.elementAt(i));
      }
    }
  }
}
