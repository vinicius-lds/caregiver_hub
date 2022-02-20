import 'package:caregiver_hub/shared/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class MultiSelectChipFieldCustom<T, K> extends StatelessWidget {
  final Stream<List<T?>>? stream;
  final List<T?>? items;
  final List<T?>? initialValue;
  final bool displayOnly;
  final FormFieldValidator<List<T?>>? validator;
  final String title;
  final String Function(T?) labelFn;
  final K Function(T?) idFn;
  final Function(List<T?>)? onTap;
  final FormFieldSetter<List<T?>>? onSaved;

  const MultiSelectChipFieldCustom({
    Key? key,
    this.stream,
    this.items,
    this.initialValue,
    this.displayOnly = false,
    this.validator,
    required this.title,
    required this.labelFn,
    required this.idFn,
    this.onTap,
    this.onSaved,
  }) : super(key: key);

  List<K> _buildInitialValue(List<T?> data) {
    if (displayOnly) {
      if (initialValue != null) {
        return initialValue!.map((e) => idFn(e)).toList();
      } else {
        return data.map((e) => idFn(e)).toList();
      }
    } else {
      if (initialValue != null) {
        return initialValue!.map((e) => idFn(e)).toList();
      }
    }
    return [];
  }

  dynamic _onTap(List<T?> data, List<K?> selectedIds) {
    if (onTap == null) {
      return null;
    }
    final selectedItems =
        data.where((item) => selectedIds.contains(idFn(item))).toList();
    return onTap!(selectedItems);
  }

  dynamic _onSaved(List<T?> data, List<K?>? selectedIds) {
    if (onSaved == null) {
      return null;
    }
    if (selectedIds == null) {
      return onSaved!([]);
    }
    final selectedItems =
        data.where((item) => selectedIds.contains(idFn(item))).toList();
    return onSaved!(selectedItems);
  }

  String? _onValidator(List<T?> data, List<K?>? selectedIds) {
    if (validator == null) {
      return null;
    }
    if (selectedIds == null) {
      return validator!(null);
    }
    final selectedItems =
        data.where((item) => selectedIds.contains(idFn(item))).toList();
    return validator!(selectedItems);
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
        validator: (selectedIds) => _onValidator(data, selectedIds),
        initialValue: _buildInitialValue(data),
        onTap: (selectedIds) => _onTap(data, selectedIds),
        onSaved: (selectedIds) => _onSaved(data, selectedIds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (stream != null) {
      return StreamBuilder<List<T?>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
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
