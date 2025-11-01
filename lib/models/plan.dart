import 'package:flutter/material.dart';
import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});

  // Tambahan baru: menghitung jumlah tugas yang sudah selesai
  int get completedCount => tasks.where((task) => task.complete).length;

  // Tambahan baru: menampilkan pesan jumlah tugas selesai
  String get completenessMessage =>
      '$completedCount out of ${tasks.length} tasks';
}
