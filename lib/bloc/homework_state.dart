import 'package:equatable/equatable.dart';
import '../models/homework.dart';

class HomeworkState extends Equatable {
  final List<Homework> homeworks;

  const HomeworkState({this.homeworks = const []});

  HomeworkState copyWith({List<Homework>? homeworks}) {
    return HomeworkState(homeworks: homeworks ?? this.homeworks);
  }

  @override
  List<Object?> get props => [homeworks];
}
