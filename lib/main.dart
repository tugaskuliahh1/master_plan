import 'package:flutter/material.dart';
import './views/plan_screen.dart';
import './models/data_layer.dart'; // Tambahan impor baru

void main() => runApp(const MasterPlanApp()); // Tambah const untuk konsistensi

class MasterPlanApp extends StatelessWidget {
  const MasterPlanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      // Bagian home diubah dari PlanScreen() menjadi PlanProvider(...)
      home: PlanProvider(
        notifier: ValueNotifier<Plan>(const Plan()),
        child: const PlanScreen(),
      ),
    );
  }
}
