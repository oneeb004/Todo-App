
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo{

  final String id;
  final String title;
  final String discription;
  final bool completed;
  final Timestamp timeStamp;

  ToDo({
    required this.id, 
    required this.title,
     required this.discription, 
     required this.completed, 
     required this.timeStamp
     });
}