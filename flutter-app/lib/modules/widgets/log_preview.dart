import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';

import '../../shared/classes/log.dart';

class LogPreview extends StatelessWidget {

  final Log log;

  const LogPreview({ 
    Key? key,
    required this.log
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MainColors.gray,
      ),
      child: ListTile(
        onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(log.title, style: TextStyles.heading,),
          content: Text('O que você deseja fazer, almirante?', style: TextStyles.text),
          backgroundColor: MainColors.gray,
          actions: <Widget>[
            IconButton(
              onPressed: () => print("visualizar registro"),
              icon: Icon(Icons.remove_red_eye, color: MainColors.blue,),
            ),
            IconButton(
              onPressed: () => print("edit registro"),
              icon: Icon(Icons.edit, color: MainColors.green,),
            ),
            IconButton(
              onPressed: () => print("excluir registro"),
              icon: Icon(Icons.delete, color: MainColors.red,),
            ),
          ],
        )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(log.title, style: TextStyles.heading),
            Text(DateFormat('dd/MM/yyyy').format(log.created_at), style: TextStyles.heading),
    
          ],
        ),
        subtitle: Column(
          children: [
            Row(children: [
              Expanded(child: ListTile(title: Text(log.mental.toString(), style: TextStyles.text,), leading: Icon(Icons.add_reaction),iconColor: MainColors.green,)),
              Expanded(child: ListTile(title: Text(log.physical.toString(), style: TextStyles.text), leading: Icon(Icons.emoji_people_sharp), iconColor: MainColors.green)),
            ],
            ),
            Row(
              children: [
                Expanded(child: ListTile(title: Text(log.professional.toString(), style: TextStyles.text), leading: Icon(Icons.work),iconColor: MainColors.green)),
                Expanded(child: ListTile(title: Text(log.social.toString(), style: TextStyles.text), leading: Icon(Icons.people_alt_outlined),iconColor: MainColors.green))
              ],
            )
          ],
        ),
      ),
    );
  }
}