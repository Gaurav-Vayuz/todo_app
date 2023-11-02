import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/provider/todo_controller.dart';
import 'package:todo_app/presentation/screens/add_todo.dart';
import 'package:todo_app/presentation/widgets/custom_search.dart';
import 'package:todo_app/presentation/widgets/todo_item.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late TodoController todoProvider;
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    todoProvider = Provider.of<TodoController>(context, listen: false);
    _getTodoList();
  }

  _getTodoList() async {
    await todoProvider.getList();
  }

  @override
  Widget build(BuildContext context) {
    todoProvider = context.watch<TodoController>();
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const AddTodo(),
                  ));
            }),
        appBar: AppBar(
          title: const Text(
            "Todo list",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: todoProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSearchBar(
                        hint: 'Search..',
                        onChanged: (val) {
                          todoProvider.searchQuery =
                              val.toString().toLowerCase().trim();
                          todoProvider.getList();
                        },
                        searchController: _searchController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Today",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      customListView(todoProvider.todayList),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Tomorrow",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      customListView(todoProvider.tomorrowList),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Upcoming",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      customListView(todoProvider.upcomingList),
                      const SizedBox(
                        height: 22,
                      ),
                    ],
                  ),
                ),
              )));
  }

  /*
   *creating custom listview widget using for all three list for today, tomorrow and upcoming list
   *Passing AddTodo custom widget and handling delete and edit events
   */
  Widget customListView(List<TodoModel> todoList) {
    return todoList.isEmpty
        ? const Text("No Data!")
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: todoList.length,
            itemBuilder: (context, index) => TodoItem(
              todo: todoList.elementAt(index),
              onDelete: () async {
                await todoProvider
                    .removeItem(todoList.elementAt(index).id ?? 0);
                todoProvider.getList();
              },
              onTapEdit: () {
                return Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddTodo(
                          isEditing: true, todo: todoList.elementAt(index)),
                    ));
              },
            ),
          );
  }
}
