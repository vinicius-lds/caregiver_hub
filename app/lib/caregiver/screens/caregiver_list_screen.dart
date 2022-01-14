import 'package:caregiver_hub/caregiver/widgets/caregiver_list_item.dart';
import 'package:caregiver_hub/shared/models/caregiver.dart';
import 'package:caregiver_hub/shared/providers/caregiver_provider.dart';
import 'package:caregiver_hub/shared/widgets/app_bar_popup_menu_button.dart';
import 'package:caregiver_hub/shared/widgets/button_footer.dart';
import 'package:caregiver_hub/shared/widgets/empty_state.dart';
import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CaregiverListScreen extends StatefulWidget {
  const CaregiverListScreen({Key? key}) : super(key: key);

  @override
  State<CaregiverListScreen> createState() => _CaregiverListScreenState();
}

class _CaregiverListScreenState extends State<CaregiverListScreen> {
  int _offset = 0;
  final int _size = 15;

  @override
  Widget build(BuildContext context) {
    final caregiverProvider = Provider.of<CaregiverProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuidadores'),
        actions: const [
          AppBarPopupMenuButton(),
        ],
      ),
      body: StreamBuilder(
        stream: CombineLatestStream.list([
          caregiverProvider.listStream(
            offset: _offset,
            size: _size,
          ),
          caregiverProvider.count(),
        ]),
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

          final data = snapshot.data as List<dynamic>;
          final caregivers = data[0] as List<Caregiver>;
          final count = data[1] as int;
          if (caregivers.isEmpty) {
            return const EmptyState(text: 'Nenhum cuidador encontrado');
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                ...caregivers
                    .map((caregiver) => CaregiverListItem(caregiver: caregiver))
                    .toList(),
                ButtonFooter(
                  primaryText: 'Próximo',
                  secondaryText: 'Anterior',
                  onPrimary: (_offset + 1) * _size > count
                      ? null
                      : () => setState(() => _offset++),
                  onSecondary:
                      _offset == 0 ? null : () => setState(() => _offset--),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
