import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/widgets/app_bar_with_back.dart';
import 'package:logbook/shared/providers/goals_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class LogView extends StatelessWidget {

  getAddressFromLatLng(lat, long) async {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          lat,
          long
        );

        Placemark place = placemarks[0];
        print(place);
        return "${place.subAdministrativeArea}\n${place.administrativeArea} - ${place.country}\n";
      } catch (e) {
        print(e);
      }
    }

  @override
  Widget build(BuildContext context) {
    LogsProvider logsProvider = context.watch<LogsProvider>();
    GoalsProvider goalsProvider = context.watch<GoalsProvider>();

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const AppBarWithBack(pageToGo: HomePage()),
      body: Container(
        height: size.height * 3,
        width: size.width,
        color: MainColors.black,
        child: Container(
          margin: EdgeInsets.only(left: size.width * 0.1, right: size.width * 0.1),
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.55,
                    alignment: Alignment.centerLeft,
                    child: Text(logsProvider.activeLog.title, maxLines: 3, overflow: TextOverflow.clip, style: TextStyles.title,)),
                  Visibility(
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.workspace_premium, color: MainColors.green,),
                          Text("Memorável", style: TextStyles.text,)
                        ],
                      ),
                    ),
                    replacement: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.workspace_premium, color: MainColors.gray,),
                          Text("Comum", style: TextStyles.text)
                        ],
                      ),
                    ),
                    visible: logsProvider.activeLog.isMemorable,
                  )
                ],
              ),
              Expanded(child: Text(logsProvider.activeLog.text, overflow: TextOverflow.visible, style: TextStyles.heading)),

              Container(
                height: size.height * 0.3,
                width: size.width * 0.8,
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.self_improvement, color: MainColors.green, size: 30),
                            ),
                            Column(
                              children: [
                                Text("Mental", style: TextStyles.text,),
                                Text(logsProvider.activeLog.mental.toString(), style: TextStyles.text,),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.sports_gymnastics_sharp, color: MainColors.green,size: 30),
                            ),
                            Column(
                              children: [
                                Text("Físico", style: TextStyles.text,),
                                Text(logsProvider.activeLog.physical.toString(), style: TextStyles.text,),
                              ],
                            )
                          ],
                        ),
                      ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.work, color: MainColors.green,size: 30),
                      ),
                      Column(
                        children: [
                          Text("Profissional", style: TextStyles.text,),                          
                          Text(logsProvider.activeLog.professional.toString(), style: TextStyles.text,),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(Icons.people_alt_outlined, color: MainColors.green,size: 30),
                      ),
                      Column(
                        children: [
                          Text("Social", style: TextStyles.text,),
                          Text(logsProvider.activeLog.social.toString(), style: TextStyles.text,),
                        ],
                        )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              ),
              Text("Localização", style: TextStyles.heading,),

              logsProvider.activeLog.lat == null 
              ? Text("")
              : FutureBuilder(
                future: getAddressFromLatLng(logsProvider.activeLog.lat, logsProvider.activeLog.long),
                builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(snapshot.data.toString(), textAlign: TextAlign.justify, style: TextStyles.text),
                  );
                }
                else{
                  return const Text("carregando localização...");
                }
              }),
              logsProvider.activeLog.lat == null 
              ? Text("Sem localização providenciada", style: TextStyles.text,)
              : Container(
                height: size.height * 0.2,
                margin: const EdgeInsets.only(bottom: 50),
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(logsProvider.activeLog.lat!, logsProvider.activeLog.long!),
                      zoom: 12,
                  ),
                  layers: [
                      TileLayerOptions(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: [
                        Marker(
                          width: 100.0,
                          height: 100.0,
                          point: LatLng(logsProvider.activeLog.lat!, logsProvider.activeLog.long!),
                          builder: (ctx) => const Icon(
                            Icons.anchor_sharp,
                            color: MainColors.black,
                            size: 50,
                          ),
                          anchorPos: AnchorPos.align(AnchorAlign.center)
                        ),
                      ])
                  ],
                ),
              ),
              Text("Metas", style: TextStyles.heading,),
              goalsProvider.allGoals.isEmpty || goalsProvider.allGoals.where((goal) => goal!.created_at.isBefore(logsProvider.activeLog.created_at)).isEmpty
              ? Text("Sem metas no período deste registro!", style: TextStyles.text,)
              : ListView(
                shrinkWrap: true,
                children: goalsProvider.allGoals
                .where((goal) => goal!.created_at.isBefore(logsProvider.activeLog.created_at))       
                .map((filteredGoal) => Text(filteredGoal!.name, style: TextStyles.text,))
                .toList()
              )
            ],
          ),
        ),
      ),
    );
  }
}