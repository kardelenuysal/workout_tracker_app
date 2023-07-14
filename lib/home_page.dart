import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker_uygulamasi/workout_data.dart';
import 'package:workout_tracker_uygulamasi/workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // text controller
  final newWorkoutNameController = TextEditingController();


  // create a new workout
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
         title: Text("Create new workout"),
        content: TextField(
        controller: newWorkoutNameController,
      ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text("save"),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ),
        ],
    ),
    );
  }

  // go to workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutPage(
      workoutName: workoutName,
    ),
    ));

  }

  // save workout
  void save() {
    // get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;
    // add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutNameController.text);

    // pop dialog box
    Navigator.pop(context);
    clear();
  }
  // cancel
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
  }

  // clear controllers
  void clear() {
    newWorkoutNameController.clear();
    clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
      appBar: AppBar(title: const Text('Workout Tracker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewWorkout,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: value.getWorkoutList().length,
        itemBuilder: (context, index) => ListTile(
          title: Text(value.getWorkoutList()[index].name),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () =>
                goToWorkoutPage(value.getWorkoutList()[index].name),

          ),
        ),
      ),
    ),
    );
  }
}


