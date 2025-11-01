import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // variabel plan dihapus karena akan diganti dengan data dari PlanProvider
  late ScrollController scrollController;

  // Getter untuk ambil plan dari widget
  Plan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Langkah 7: Widget build menggunakan List<Plan> dari PlanProvider
  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier =
        PlanProvider.of(context) as ValueNotifier<List<Plan>>;

    return Scaffold(
      appBar: AppBar(title: Text(plan.name)), // gunakan getter plan
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          // cari plan aktif berdasarkan nama
          Plan currentPlan = plans.firstWhere(
            (p) => p.name == plan.name,
            orElse: () => plan,
          );

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  // Tombol untuk menambah task baru
  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier =
        PlanProvider.of(context) as ValueNotifier<List<Plan>>;

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Plan currentPlan = plan;

        // cari posisi plan aktif di list
        int planIndex = planNotifier.value.indexWhere(
          (p) => p.name == currentPlan.name,
        );

        // buat daftar task baru dengan tambahan task kosong
        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task());

        // update plan di posisi yang benar
        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(name: currentPlan.name, tasks: updatedTasks);

        // update juga plan lokal
        setState(() {
          currentPlan = Plan(name: currentPlan.name, tasks: updatedTasks);
        });
      },
    );
  }

  // Langkah 8: Edit _buildTaskTile untuk mendukung List<Plan>
  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier =
        PlanProvider.of(context) as ValueNotifier<List<Plan>>;

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = plan;
          int planIndex = planNotifier.value.indexWhere(
            (p) => p.name == currentPlan.name,
          );

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        decoration: const InputDecoration(hintText: 'Tulis deskripsi tugas...'),
        onChanged: (text) {
          Plan currentPlan = plan;
          int planIndex = planNotifier.value.indexWhere(
            (p) => p.name == currentPlan.name,
          );

          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: List<Task>.from(currentPlan.tasks)
                ..[index] = Task(description: text, complete: task.complete),
            );
        },
      ),
    );
  }

  // Langkah 7: versi baru _buildList menerima Plan langsung
  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index, context),
    );
  }
}
