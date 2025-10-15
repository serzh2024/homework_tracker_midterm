import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/homework.dart';
import 'homework_event.dart';
import 'homework_state.dart';

class HomeworkBloc extends Bloc<HomeworkEvent, HomeworkState> {
  HomeworkBloc() : super(const HomeworkState()) {
    _loadHomeworks();

    on<AddHomework>((event, emit) async {
      final updated = List<Homework>.from(state.homeworks)..add(event.homework);
      emit(state.copyWith(homeworks: updated));
      await _saveHomeworks(updated);
    });

    on<ToggleHomeworkCompletion>((event, emit) async {
      final updated = state.homeworks.map((hw) {
        if (hw.id == event.homeworkId) {
          return hw.copyWith(isCompleted: !hw.isCompleted);
        }
        return hw;
      }).toList();
      emit(state.copyWith(homeworks: updated));
      await _saveHomeworks(updated);
    });
  }

  Future<void> _saveHomeworks(List<Homework> homeworks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = homeworks.map((hw) => json.encode(hw.toMap())).toList();
    await prefs.setStringList('homeworks', encoded);
  }

  Future<void> _loadHomeworks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList('homeworks') ?? [];
    final loaded = encoded.map((e) => Homework.fromMap(json.decode(e))).toList();
    emit(state.copyWith(homeworks: loaded));
  }
}
