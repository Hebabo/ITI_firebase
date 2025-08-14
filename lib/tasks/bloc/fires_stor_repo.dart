import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseiti/tasks/models/task_model.dart';

class FiresStorRepo {
  /// FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _tasks = FirebaseFirestore.instance.collection(
    'tasks',
  );

  // CRUD
  /// Create add
  Future<void> addTask(Task task) async {
    await _tasks.add(task.toFirestore());
  }

  //R > Read
  Stream<List<Task>> getTasks(String createdAt) {
    return _tasks.orderBy(createdAt, descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map(
            (doc) =>
                Task.fromFirestore(doc.id, doc.data() as Map<String, dynamic>),
          )
          .toList();
    });
  }

  // U >> Update
  Future<void> updataTask(Task task) async {
    await _tasks.doc(task.id).update(task.toFirestore());
  }

  // D delete
  Future<void> deleteTask(String taskId) async {
    await _tasks.doc(taskId).delete();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    await _tasks.doc(task.id).update({
      'isCompleted': !task.isCompleted,
    });
  }
}
