import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/activity.dart';
import '../widgets/activity_tile.dart';

class ActivityLogScreen extends StatefulWidget {
  static const routeName = '/activities';

  const ActivityLogScreen({super.key});

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  final titleController = TextEditingController();
  final typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Activity Log")),
      body: ListView.builder(
        itemCount: state.activities.length,
        itemBuilder: (ctx, i) {
          final a = state.activities[i];
          return Dismissible(
            key: Key(a.id),
            onDismissed: (_) => state.removeActivity(a),
            background: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Delete",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            child: ActivityTile(
              title: a.title,
              subtitle:
                  "${a.type} • ${DateFormat.yMd().add_jm().format(a.timestamp)}",
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(state),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(AppProvider state) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Activity"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "Type"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final act = Activity(
                title: titleController.text,
                type: typeController.text,
                timestamp: DateTime.now(),
              );
              state.addActivity(act);
              titleController.clear();
              typeController.clear();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
