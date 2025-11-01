export 'plan.dart';
export 'task.dart';

import 'package:flutter/material.dart';
import 'plan.dart';

// Tambahkan class PlanProvider di bawah ini
class PlanProvider extends InheritedWidget {
  final ValueNotifier<Plan> notifier;

  const PlanProvider({required this.notifier, required super.child, super.key});

  static ValueNotifier<Plan> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    assert(provider != null, 'No PlanProvider found in context');
    return provider!.notifier;
  }

  @override
  bool updateShouldNotify(covariant PlanProvider oldWidget) {
    return oldWidget.notifier != notifier;
  }
}
