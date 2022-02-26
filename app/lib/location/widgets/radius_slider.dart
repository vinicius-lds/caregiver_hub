import 'package:flutter/material.dart';

const double km = 1000;

class RadiusSlider extends StatefulWidget {
  final double? initialValue;
  final double minValue;
  final double maxValue;
  final Function(double) onChanged;

  const RadiusSlider({
    Key? key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RadiusSliderState createState() => _RadiusSliderState();
}

class _RadiusSliderState extends State<RadiusSlider> {
  double? _meters;

  @override
  void initState() {
    _meters = widget.initialValue ?? widget.minValue;
  }

  void _onValueChanged(double value) {
    final newValue = double.parse((value / km).toStringAsFixed(1)) * km;
    if (_meters != newValue) {
      setState(() => _meters = newValue);
      widget.onChanged(_meters!);
    }
  }

  get _kilometersValue {
    return (_meters! / km).toStringAsFixed(1).replaceAll('.', ',') + ' km';
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RotatedBox(
                quarterTurns: 1,
                child: Text(_kilometersValue),
              ),
              Slider(
                min: widget.minValue,
                max: widget.maxValue,
                value: _meters!,
                onChanged: _onValueChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
