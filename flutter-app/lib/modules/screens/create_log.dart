import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logbook/modules/screens/home_page.dart';
import 'package:logbook/modules/widgets/app_bar_with_back.dart';
import 'package:logbook/modules/widgets/app_drawer.dart';
import 'package:logbook/modules/widgets/custom_button.dart';
import 'package:logbook/modules/widgets/input.dart';
import 'package:logbook/modules/widgets/input_with_controller.dart';
import 'package:logbook/shared/classes/log.dart';
import 'package:logbook/shared/providers/login_provider.dart';
import 'package:logbook/shared/providers/logs_provider.dart';
import 'package:logbook/shared/theme/main_colors.dart';
import 'package:logbook/shared/theme/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class CreateLog extends StatefulWidget {
  const CreateLog({ Key? key }) : super(key: key);

  @override
  State<CreateLog> createState() => _CreateLogState();
}

class _CreateLogState extends State<CreateLog> {

  final _formKey = GlobalKey<FormState>();

  int? id;
  String? title;
  String? text;
  DateTime? created_at = DateTime.now();
  bool isMemorable = false;
  TextEditingController created_atText = TextEditingController();
  DateTime? completed_at;
  double? mental;
  double? physical;
  double? social;
  double? professional;
  Position? currentPosition;

  checkPermissions() async {
    var permission = await Geolocator.requestPermission();
   bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Localização Desabilitada!", style: TextStyles.heading,),
          content: Text('lembre-se de ativar a localização no seu celular, almirante!', style: TextStyles.text),
          backgroundColor: MainColors.gray,
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Entendi!")
            ),
          ],
        ));
    }
  }

  getCurrentLocation() async {
    try{
      print("BUSCA INICIADA");
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium, 
        forceAndroidLocationManager: true,
        //timeLimit: Duration(seconds: 5)
      );
      print(position);
      return position;

    } catch(e){
      print("CAIU NO CATCH");
      return false;
    }
  }

  @override
  void initState() {
    setState(() {
      created_atText.text = DateFormat('dd/MM/yyyy').format(created_at!);
    });  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    LoginProvider loginProvider = context.read<LoginProvider>();
    LogsProvider logsProvider = context.read<LogsProvider>();

    final size = MediaQuery.of(context).size;

    checkPermissions();
    
    return Hero(
      tag: "create",
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarWithBack(pageToGo: HomePage()),
        backgroundColor: MainColors.black,
        body: Container(
          width: size.width * 0.8,
          margin: EdgeInsets.only(left: size.width * 0.1),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Input(
                    height: size.height * 0.1,
                    width: size.width * 0.8,
                    label: "Nome do Registro",
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        data: ThemeData(
                        unselectedWidgetColor: MainColors.gray, // Your color
                      ),
                        child: Checkbox(value: isMemorable, activeColor: MainColors.green, onChanged: (value){
                          setState(() {
                            isMemorable = value!;
                          });
                        }),
                      ),
                      Text("É um registro memorável?", style: TextStyles.fieldText,),
                    ],
                  ),
                ),
                Input(
                      label: "O que aconteceu, marujo?", 
                      height: size.height * 0.35, 
                      width: size.width * 0.8,
                      onChanged: (value) {
                        setState(() {
                          text = value;
                        });
                      },
                    ),
                SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputWithController( 
                        label: "Data do Registro",
                        height: size.height * 0.1,
                        width: size.width * 0.54,
                        enabled: false, 
                        controller: created_atText,
                      ),
                      CustomButton(
                        icon: Icons.date_range,
                        size: Size(size.width * 0.1, size.height * 0.05),
                        onPressed: ()async {
                          showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2030))
                            .then((date) {
                          setState(() {
                            created_at = date;
                            created_atText.text =  DateFormat('dd/MM/yyyy').format(date!);
                          });
                        });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                  child: Center(
                    child: CustomButton(
                      icon: Icons.send,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var pos = await getCurrentLocation();
                          if (pos != false){
                            setState(() {
                              currentPosition = pos;
                            });
                          }

                          Log log = Log(
                            title: title!, 
                            text: text!, 
                            created_at: created_at!, 
                            isMemorable: isMemorable,
                            lat: currentPosition?.latitude,
                            long: currentPosition?.longitude,
                            mental: loginProvider.mental, 
                            physical: loginProvider.mental, 
                            social: loginProvider.mental, 
                            professional: loginProvider.professional);
                    
                          await logsProvider.createLog(loginProvider.googleId, log);
                          Navigator.pushReplacementNamed(context, "/home");
                        }
                    
                      }, 
                      size: Size(size.width * 0.5, size.height * 0.08)
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}