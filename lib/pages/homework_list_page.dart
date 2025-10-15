import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/homework_bloc.dart';
import '../bloc/homework_event.dart';
import '../bloc/homework_state.dart';

class HomeworkListPage extends StatelessWidget {
  const HomeworkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework Tracker'),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeworkBloc, HomeworkState>(
        builder: (context, state) {
          if (state.homeworks.isEmpty) {
            return const Center(
              child: Text('No homework added yet.'),
            );
          }

          return ListView.builder(
            itemCount: state.homeworks.length,
            itemBuilder: (context, index) {
              final hw = state.homeworks[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    hw.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: hw.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    '${hw.subject} • Due: ${hw.dueDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  trailing: Checkbox(
                    value: hw.isCompleted,
                    onChanged: (_) {
                      context.read<HomeworkBloc>().add(ToggleHomeworkCompletion(hw.id));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/00add'),
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
