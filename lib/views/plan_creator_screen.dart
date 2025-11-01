import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import 'plan_screen.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ganti dengan nama panggilanmu
      appBar: AppBar(title: const Text('Master Plans Ismi')),
      body: Column(
        children: [
          _buildListCreator(),
          Expanded(child: _buildMasterPlans()),
        ],
      ),
    );
  }

  // Langkah 12: Widget input untuk menambah plan baru
  Widget _buildListCreator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Add a plan',
            contentPadding: EdgeInsets.all(20),
          ),
          onEditingComplete: addPlan, // dipanggil ketika tekan Enter
        ),
      ),
    );
  }

  // Langkah 13: Menambah plan baru ke daftar PlanProvider
  void addPlan() {
    final text = textController.text;
    if (text.isEmpty) return; // jika kosong, keluar

    final plan = Plan(name: text, tasks: []); // buat plan baru
    ValueNotifier<List<Plan>> planNotifier =
        PlanProvider.of(context) as ValueNotifier<List<Plan>>;

    // tambahkan ke list plan
    planNotifier.value = List<Plan>.from(planNotifier.value)..add(plan);

    // bersihkan input dan tutup keyboard
    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {}); // perbarui tampilan
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  // Langkah 14: Widget untuk menampilkan daftar plan
  Widget _buildMasterPlans() {
    ValueNotifier<List<Plan>> planNotifier =
        PlanProvider.of(context) as ValueNotifier<List<Plan>>;

    return ValueListenableBuilder<List<Plan>>(
      valueListenable: planNotifier,
      builder: (context, plans, _) {
        if (plans.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.note, size: 100, color: Colors.grey),
              Text(
                'Anda belum memiliki rencana apapun.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          );
        }

        return ListView.builder(
          itemCount: plans.length,
          itemBuilder: (context, index) {
            final plan = plans[index];
            return ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.completenessMessage),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PlanScreen(plan: plan)),
                );
              },
            );
          },
        );
      },
    );
  }
}
