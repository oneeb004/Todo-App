import 'package:flutter/material.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/service/auth_service.dart';
import 'package:to_do_app/service/database_service.dart';
import 'package:to_do_app/views/auth/login_screen.dart';
import 'package:to_do_app/views/home/widgets/completed_widget.dart';
import 'package:to_do_app/views/home/widgets/pending_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int buttonIndex = 0;
  final _widgets = [
    //pending task widgets
    Pending(),

    //completed task
    Completed(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      appBar: AppBar(
        backgroundColor: Color(0xFF1d2630),
        foregroundColor: Colors.white,
        title: Text(
          "Home Page",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService().singnOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      buttonIndex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: buttonIndex == 0 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: buttonIndex == 0 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color:
                              buttonIndex == 0 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      buttonIndex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: buttonIndex == 1 ? Colors.indigo : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: buttonIndex == 1 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color:
                              buttonIndex == 1 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            _widgets[buttonIndex]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
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
