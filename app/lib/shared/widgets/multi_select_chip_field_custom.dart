import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectChipFieldCustom<T, K> extends StatelessWidget {
  final Stream<List<T?>>? stream;
  final List<T?>? items;
  final bool displayOnly;
  final String title;
  final String Function(T?) labelFn;
  final K Function(T?) idFn;
  final Function(List<T?>)? onTap;

  const MultiSelectChipFieldCustom({
    Key? key,
    this.stream,
    this.items,
    this.displayOnly = false,
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

  Widget _buildFromData(
    List<T?> data,
    BuildContext context,
  ) {
    return AbsorbPointer(
      absorbing: displayOnly,
      child: MultiSelectChipField<K?>(
        items:
            data.map((e) => MultiSelectItem<K?>(idFn(e), labelFn(e))).toList(),
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
        initialValue: displayOnly ? data.map((e) => idFn(e)).toList() : [],
        onTap: (selectedIds) => _onTap(data, selectedIds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stream != null) {
      return StreamBuilder<List<T?>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          }
          final List<T?> data = snapshot.data ?? [];
          return _buildFromData(data, context);
        },
      );
    } else {
      return _buildFromData(items!, context);
    }
  }
}
