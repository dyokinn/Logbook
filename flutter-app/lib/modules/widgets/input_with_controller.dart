import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';

class InputWithController extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final double height;
  final double width;
  final bool enabled;
  final Function(String)? onChanged;
  
  const InputWithController(
    {Key? key,
    required this.label,
    required this.controller,
    required this.height,
    required this.width,
    this.enabled = true,
    this.onChanged
    })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height: height,
          width: width,
          child: TextFormField(
            minLines: null,
            maxLines: null,
            expands: true,
            onChanged: (String? newValue) {
                onChanged!(newValue!);
              },
            enabled: enabled,
            textAlign: TextAlign.center,
            controller: controller,
            style: TextStyles.fieldText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, preencha este campo';
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: MainColors.gray,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              label: Center(child: Text(label)),
              labelStyle: TextStyles.fieldText
          ),
        ),
      );
  }
}