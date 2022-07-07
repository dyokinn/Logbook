import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/main_colors.dart';

class Input extends StatelessWidget {
  final String label;
  final String? initialValue;
  final double height;
  final double width;
  final bool enabled;
  final Function(String)? onChanged;
  
  const Input(
    {Key? key,
    required this.label,
    this.initialValue = "",
    required this.height,
    required this.width,
    this.enabled = true,
    this.onChanged
    })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          height: height,
          width: width,
          child: TextFormField(
            onChanged: (String? newValue) {
                onChanged!(newValue!);
              },
            enabled: enabled,
            textAlign: TextAlign.center,
            initialValue: initialValue,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, preencha este campo';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: MainColors.gray,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              label: Center(child: Text(label)),
              labelStyle: TextStyle(
                color: Colors.black54,
                fontSize: 12,
              ),
          ),
        ),
      );
  }
}