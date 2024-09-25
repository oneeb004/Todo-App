import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/service/database_service.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;
  final DatabaseService databaseService = DatabaseService();

  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
        stream: databaseService.completedtodos,
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
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: "Delete",
                            onPressed: (context) {
                              databaseService.deleteToDoTask(todo.id);
                            },
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough),
                        ),
                        subtitle: Text(
                          todo.discription,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        trailing: Text(
                          '${dt.day}/${dt.month}/${dt.year}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
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
}
