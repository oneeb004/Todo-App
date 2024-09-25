import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/service/database_service.dart';

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
        stream: databaseService.todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ToDo> todos = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  ToDo todo = todos[index];
                  final DateTime dt = todo.timeStamp.toDate();
                  return Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              icon: Icons.done,
                              label: "Mark",
                              onPressed: (context) {
                                databaseService.updateToDoStatus(todo.id, true);
                              })
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: "Edit",
                              onPressed: (context) {
                                _showDialog(context, todo: todo);
                              }),
                          SlidableAction(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: "Delete",
                              onPressed: (context) {
                                databaseService.deleteToDoTask(todo.id);
                              })
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          todo.discription,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Text(
                          '${dt.day}/${dt.month}/${dt.year}',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }

  void _showDialog(BuildContext context, {ToDo? todo}) {
    final TextEditingController titleController =
        TextEditingController(text: todo?.title);
    final TextEditingController descriptionController =
        TextEditingController(text: todo?.discription);
    final DatabaseService databaseService = DatabaseService();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              todo == null ? "Add Task" : "Edit Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white60),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white),
                onPressed: () async {
                  if (todo == null) {
                    await databaseService.addToDoTask(
                      titleController.text.toString(),
                      descriptionController.text.toString(),
                    );
                  } else {
                    await databaseService.updateToDoTask(
                      todo.id,
                      titleController.text.toString(),
                      descriptionController.text.toString(),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(todo == null ? "Add" : "Update"),
              ),
            ],
          );
        });
  }
}
