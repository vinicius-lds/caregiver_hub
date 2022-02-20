import 'package:caregiver_hub/caregiver/widgets/caregiver_list_item.dart';
import 'package:caregiver_hub/shared/constants/pagination.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CaregiverListScreen extends StatefulWidget {
  const CaregiverListScreen({Key? key}) : super(key: key);

  @override
  State<CaregiverListScreen> createState() => _CaregiverListScreenState();
}

class _CaregiverListScreenState extends State<CaregiverListScreen> {
  int _size = pageSize;

  @override
  Widget build(BuildContext context) {
    final caregiverProvider = Provider.of<CaregiverProvider>(context);
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidadores'),
        actions: [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder(
        stream: caregiverProvider.listStream(size: _size),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              width: double.infinity,
              child: Loading(),
            );
          }
          if (!snapshot.hasData) {
            return const EmptyState(text: 'Nenhum cuidador encontrado');
          }

          final caregivers = snapshot.data as List<Caregiver>;
          if (caregivers.isEmpty) {
            return const EmptyState(text: 'Nenhum cuidador encontrado');
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ...caregivers
                    .map((caregiver) => CaregiverListItem(caregiver: caregiver))
                    .toList(),
                if (caregivers.length == _size)
                  ElevatedButton(
                    child: Text(
                      'Carregar mais',
                      style: TextStyle(
                        fontSize: 15 * textScaleFactor,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    onPressed: () => setState(() => _size += pageSize),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
