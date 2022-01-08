import 'package:caregiver_hub/employer/models/caregiver.dart';
import 'package:caregiver_hub/employer/providers/caregiver_provider.dart';
import 'package:caregiver_hub/employer/widgets/caregiver_list_item/caregiver_list_item.dart';
import 'package:caregiver_hub/shared/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CaregiverListScreenMat extends StatelessWidget {
  const CaregiverListScreenMat({Key? key}) : super(key: key);

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
          final data = snapshot.data as List<Caregiver>;
          if (data.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Image.asset('assets/images/nothing_found.png'),
                  const Text('Nenhum cuidador encontrado'),
                ],
              ),
            );
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
