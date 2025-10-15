import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../bloc/homework_bloc.dart';
import '../bloc/homework_event.dart';
import '../models/homework.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  final _subjectController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveHomework() {
    final subject = _subjectController.text.trim();
    final title = _titleController.text.trim();
    final dueDate = _selectedDate;

    if (subject.isEmpty || title.isEmpty || dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final id = const Uuid().v4();

    final homework = Homework(
      id: id,
      subject: subject,
      title: title,
      dueDate: dueDate,
    );

    context.read<HomeworkBloc>().add(AddHomework(homework));
    Navigator.pop(context); // Go back to list page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Homework'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Homework Title / Description'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date chosen'
                        : 'Due: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _saveHomework,
              icon: const Icon(Icons.save),
              label: const Text('Save Homework'),
            ),
          ],
        ),
      ),
    );
  }
}
