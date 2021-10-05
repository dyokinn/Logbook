import 'package:flutter/material.dart';
import 'package:logbook/shared/theme/text_styles.dart';

class GoalsTab extends StatelessWidget {
  const GoalsTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("aoo, é o metas", style: TextStyles.text)),
    );
  }
}