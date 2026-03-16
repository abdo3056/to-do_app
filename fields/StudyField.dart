import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/test_cubit.dart';
import 'package:my_app/cubit/test_state.dart';

class StudyField extends StatefulWidget {
  const StudyField({super.key});

  @override
  State<StudyField> createState() => _StudyFieldState();
}

class _StudyFieldState extends State<StudyField> {
  TextEditingController taskController = TextEditingController();
  String category = 'Study';

  @override
  void initState() {
    super.initState();
    context.read<TestCubit>().getTasks(category);

  }

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  void _showTaskDialog({int? id, String? initialText}) {
    if (initialText != null) {
      taskController.text = initialText;
    } else {
      taskController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  id == null ? "Add new task" : "Edit task",
                  style: const TextStyle(fontSize: 30, fontFamily: 'Dancing'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: taskController,
                  autofocus: true,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    hintText: "Enter task",
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (taskController.text.isNotEmpty) {
                        if (id == null) {
                          context.read<TestCubit>().addTask(taskController.text, category);
                        } else {
                          context.read<TestCubit>().editTask(taskController.text,id, category);
                        }
                        taskController.clear();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 5,
                      shadowColor: Colors.grey,
                      padding: const EdgeInsets.all(15),
                      fixedSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      id == null ? "Add" : "Update",
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[300]!, Colors.blue[700]!],
              ),
            ),
          ),
          title: const Text(
            "Study",
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Dancing',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[300]!, Colors.blue[700]!],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Tasks",
                    style: TextStyle(fontSize: 35, fontFamily: 'Dancing'),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<TestCubit, TestState>(
                    builder: (context, state) {
                      if (state is TestLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final tasks = state.tasks;
                      if (tasks.isEmpty) {
                        return const Center(
                          child: Text("Your list is empty, add a new task!"),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: tasks.length,
                        itemBuilder: (context, i) {
                          final task = tasks[i];
                          final bool isDone = task['is_done'] == 1;

                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Checkbox(
                                value: isDone,
                                activeColor: Colors.blue[700],
                                onChanged: (value) {
                                  context.read<TestCubit>().toggleStatus(task['id'], value!, category);
                                },
                              ),
                              title: Text(
                                task['task'] ?? '',
                                style: TextStyle(
                                  decoration: isDone ? TextDecoration.lineThrough : null,
                                  color: isDone
                                      ? Colors.grey
                                      : (isDarkMode ? Colors.white : Colors.black),
                                ),
                              ),
                              onTap: () => _showTaskDialog(
                                id: task['id'],
                                initialText: task['task'],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  context.read<TestCubit>().deleteTask(task['id'], category);
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          FloatingActionButton(
            heroTag: 'addBTN',
            backgroundColor: Colors.blue[700],
            onPressed: () => _showTaskDialog(),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          FloatingActionButton(
            heroTag: 'delBTN',
            backgroundColor: Colors.blue[700],
            onPressed: () {
              context.read<TestCubit>().removeAll(category);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All tasks deleted!"),
                    duration: Duration(seconds: 2),
                  )
              );
            },
            child: const Icon(Icons.cleaning_services_rounded, color: Colors.white),
          )
        ],
      ),
    );
  }
}
