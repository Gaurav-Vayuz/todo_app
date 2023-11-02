import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/utils/app_utils.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final dynamic onDelete;
  final dynamic onTapEdit;
  const TodoItem(
      {super.key, required this.todo, this.onDelete, this.onTapEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        title: Text(
          AppUtils.capitalizeFirstLetter(todo.title),
          style: const TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppUtils.capitalizeFirstLetter(
                  todo.desc == "" ? "NA" : todo.desc),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              AppUtils.formatDate(DateTime.parse(todo.date)),
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
        trailing: Wrap(
          children: [
            IconButton(
                onPressed: onTapEdit,
                icon: const Icon(Icons.edit, color: Colors.green)),
            IconButton(
                onPressed: onDelete,
                icon: const Icon(CupertinoIcons.trash, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
