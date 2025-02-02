import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _toggleTaskCompletion(String taskId, bool isCompleted) {
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .update({'completed': !isCompleted});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Beslenme Önerileri"),
        backgroundColor: Colors.green[600],
      ),
      body: StreamBuilder(
        stream: _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('tasks')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var tasks = snapshot.data!.docs;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var task = tasks[index];
              return CheckboxListTile(
                title: Text(task['title']),
                value: task['completed'],
                onChanged: (val) =>
                    _toggleTaskCompletion(task.id, task['completed']),
              );
            },
          );
        },
      ),
    );
  }
}
