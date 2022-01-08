import 'package:caregiver_hub/shared/validation/validators.dart';
import 'package:caregiver_hub/shared/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectChipFieldStreamMat<T, K> extends StatelessWidget {
  final Stream<List<T?>> items;
  final String title;
  final String Function(T?) labelFn;
  final K Function(T?) idFn;
  final Function(List<T?>)? onTap;

  const MultiSelectChipFieldStreamMat({
    Key? key,
    required this.items,
    required this.title,
    required this.labelFn,
    required this.idFn,
    this.onTap,
  }) : super(key: key);

  dynamic _onTap(List<T?> data, List<K?> selectedIds) {
    if (onTap == null) {
      return null;
    }
    final selectedItems =
        data.where((item) => selectedIds.contains(idFn(item))).toList();
    return onTap!(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T?>>(
      stream: items,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Loading();
        }
        final List<T?> data = snapshot.data ?? [];
        return MultiSelectChipField<K?>(
          items: data
              .map((e) => MultiSelectItem<K?>(idFn(e), labelFn(e)))
              .toList(),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          headerColor: Theme.of(context).primaryColor,
          selectedChipColor: Theme.of(context).colorScheme.primary,
          selectedTextStyle: const TextStyle(color: Colors.white),
          scroll: false,
          onTap: (selectedIds) => _onTap(data, selectedIds),
        );
      },
    );
  }
}
