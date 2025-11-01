import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './views/plan_creator_screen.dart';
import './models/data_layer.dart'; // Tambahan impor baru

void main() => runApp(const MasterPlanApp()); // Tambah const untuk konsistensi

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: ValueNotifier<List<Plan>>([]),
      child: MaterialApp(
        title: 'State management app',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const PlanCreatorScreen(),
      ),
    );
  }
}
