import 'package:equatable/equatable.dart';
import '../models/homework.dart';

abstract class HomeworkEvent extends Equatable {
  const HomeworkEvent();
  @override
  List<Object?> get props => [];
}

class AddHomework extends HomeworkEvent {
  final Homework homework;
  const AddHomework(this.homework);
  @override
  List<Object?> get props => [homework];
}

class ToggleHomeworkCompletion extends HomeworkEvent {
  final String homeworkId;
  const ToggleHomeworkCompletion(this.homeworkId);
  @override
  List<Object?> get props => [homeworkId];
}
