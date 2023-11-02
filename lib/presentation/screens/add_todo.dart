import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/utils/app_utils.dart';
import 'package:todo_app/data/model/todo_model.dart';
import 'package:todo_app/presentation/provider/todo_controller.dart';

class AddTodo extends StatefulWidget {
  final bool isEditing;
  final TodoModel? todo;
  const AddTodo({super.key, this.isEditing = false, this.todo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  late TodoController todoProvider;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.desc;
      _selectedDate = DateTime.parse(widget.todo!.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    todoProvider = Provider.of<TodoController>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isEditing ? "Edit Todo" : "Create Todo",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.textFiledDesign(_titleController, "Title",
                  validator: (val) {
                if (val.isEmpty) {
                  return 'Please enter title';
                }
              }, autoFocus: true),
              const SizedBox(
                height: 15,
              ),
              AppUtils.textFiledDesign(_descriptionController, "Description"),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Wrap(
                  children: [
                    Text(AppUtils.formatDate(_selectedDate)),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.deepPurple,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _onTap,
                  child: Text(widget.isEditing ? "Edit Todo" : "Create Todo"),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  /*
  * Handling on tap event of button here, performing edit and new task creation respectively
  */
  void _onTap() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!widget.isEditing) {
      await todoProvider.addTodo(
          _titleController.text,
          _descriptionController.text,
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
              .toString());
    } else {
      await todoProvider.editTodo(
          widget.todo!.id ?? 0,
          _titleController.text,
          _descriptionController.text,
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
              .toString());
    }
    todoProvider.getList();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  /*
  * Selecting date and parsing only year, month and day in datetime
  */
  Future<void> _selectDate(BuildContext context) async {
    var picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = AppUtils.formatDate(_selectedDate);
      });
    }
  }
}
