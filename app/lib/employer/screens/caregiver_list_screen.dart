import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/providers/caregiver_provider.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_list_item.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CaregiverListScreen extends StatelessWidget {
  const CaregiverListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final caregiverProvider = Provider.of<CaregiverProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CaregiverHub'),
      ),
      body: StreamBuilder(
        stream: caregiverProvider.listStream(),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SizedBox(
              width: double.infinity,
              child: Loading(),
            );
          }
          if (!snapshot.hasData) {
            return const EmptyState(text: 'Nenhum cuidador encontrado');
          }
          final data = snapshot.data as List<Caregiver>;
          if (data.isEmpty) {
            return const EmptyState(text: 'Nenhum cuidador encontrado');
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CaregiverListItem(
                  caregiver: data[index],
                );
              },
              itemCount: data.length,
            ),
          );
        },
      ),
    );
  }
}
