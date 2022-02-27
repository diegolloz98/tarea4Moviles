import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_track/user_page/cuenta.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:feature_discovery/feature_discovery.dart';

import 'bloc/picture_bloc.dart';
import 'circular_button.dart';
import 'cuenta_item.dart';
import 'package:http/http.dart' as http;
import 'bloc/cuentas_bloc.dart';
class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String _usersDataUrl = "https://api.sheety.co/12948897d56ef720d45bb409c83b07ad/dummyApi/cuentas";
  var feature1EnablePulsingAnimation = true;
  ScreenshotController _screenshotController = ScreenshotController();

  Future _getUserData() async {
    try{
      http.Response response = await http.get(Uri.parse(_usersDataUrl));
      if(response.statusCode == HttpStatus.ok){
        var result = jsonDecode(response.body);
        return result;
      }
    }catch(e){
      print(e);
    }
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(context,
          <String>[
            'feature1',
            'feature2',
            'feature3',
            'feature4',
          ]
      );
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DescribedFeatureOverlay(
            featureId: 'feature4',
            targetColor: Colors.white,
            textColor: Colors.black,
            backgroundColor: Colors.pink,
            contentLocation: ContentLocation.trivial,
            title: Text('Compartir',style: TextStyle(fontSize: 20.0),),
            pulseDuration: Duration(seconds: 1),
            enablePulsingAnimation: true,
            barrierDismissible: false,
            overflowMode: OverflowMode.wrapBackground,
            openDuration: Duration(seconds: 1),
            description: Text('Boton para compartir screenshot'),
            tapTarget: Icon(Icons.share),
            child: IconButton(
              tooltip: "Compartir pantalla",
              onPressed: () {
                _tomarScreenshotyCompartir();
                print("take screen");
              },
              icon: Icon(Icons.share),
            ),
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocConsumer<PictureBloc, PictureState>(
                    listener: (context, state) {
                      if (state is PictureErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${state.errorMsg}")),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PictureSelectedState) {
                        return CircleAvatar(
                          backgroundImage: FileImage(state.picture!),
                          minRadius: 40,
                          maxRadius: 80,
                        );
                      } else {
                        return CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 122, 113, 113),
                          minRadius: 40,
                          maxRadius: 80,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Bienvenido",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text("Usuario${UniqueKey()}"),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      
                        DescribedFeatureOverlay(
                          featureId: 'feature3',
                          targetColor: Colors.white,
                          textColor: Colors.black,
                          backgroundColor: Colors.amber,
                          contentLocation: ContentLocation.trivial,
                          title: Text('Tarjeta',style: TextStyle(fontSize: 20.0),),
                          pulseDuration: Duration(seconds: 1),
                          enablePulsingAnimation: true,
                          barrierDismissible: false,
                          overflowMode: OverflowMode.wrapBackground,
                          openDuration: Duration(seconds: 1),
                          description: Text('Boton para ver tarjeta'),
                          tapTarget: Icon(Icons.credit_card),
                          child: CircularButton(
                            textAction: "Ver tarjeta",
                            iconData: Icons.credit_card,
                            bgColor: Color(0xff123b5e),
                            action: (){},
                          ),
                        ),
                      
                      DescribedFeatureOverlay(
                        featureId: 'feature2',
                        targetColor: Colors.white,
                        textColor: Colors.white,
                        backgroundColor: Colors.blue,
                        contentLocation: ContentLocation.below,
                        title: Text('Cámara',style: TextStyle(fontSize: 20.0),),
                        pulseDuration: Duration(seconds: 1),
                        enablePulsingAnimation: true,
                        overflowMode: OverflowMode.clipContent,
                        openDuration: Duration(seconds: 1),
                        description: Text('Usar camara para cambiar foto de perfil'),
                        tapTarget: Icon(Icons.camera_alt),
                        child: CircularButton(
                          textAction: "Cambiar foto",
                          iconData: Icons.camera_alt,
                          bgColor: Colors.orange,
                          action: () {
                            BlocProvider.of<PictureBloc>(context).add(
                              ChangeImageEvent(),
                            );
                          },
                        ),
                      ),
                      DescribedFeatureOverlay(
                        featureId: 'feature1',
                        targetColor: Colors.white,
                        textColor: Colors.black,
                        backgroundColor: Colors.purpleAccent,
                        contentLocation: ContentLocation.above,
                        title: Text('Tutorial',style: TextStyle(fontSize: 20.0),),
                        pulseDuration: Duration(seconds: 1),
                        enablePulsingAnimation: true,
                        barrierDismissible: false,
                        overflowMode: OverflowMode.extendBackground,
                        openDuration: Duration(seconds: 1),
                        description: Text('Ver tutorial para utilizar la app'),
                        tapTarget: Icon(Icons.play_arrow),
                        
                        child: CircularButton(
                          textAction: "Ver tutorial",
                          iconData: Icons.play_arrow,
                          bgColor: Colors.green,
                          action: (){
                            print(_getUserData());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48),
                  BlocBuilder<CuentasBloc, CuentasState>(
                    builder: (context, state){
                      if(state is LoadedState){
                        return ListView.builder(
                                itemCount: state.cuentas.length,
                                itemBuilder: (context, index) {
                                  Cuenta cuentas = state.cuentas[index];
                                 return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(cuentas.tarjeta),
                                    ),
                                    title: Text(cuentas.dinero, maxLines: 1),
                                    subtitle: Text(cuentas.cuenta,),
                                  ),
                                );
                              },
                            );
                        }else if(state is FailedToLoadState){
                          print(state.error);
                          return Center(child: Text(state.error));
                        }
                    return Center(child: CircularProgressIndicator());
                  }
                  ),
                ],
              ),
            ),
          ),
        
      ),
    );
  }
  
  void _tomarScreenshotyCompartir() async {
	final uint8List = await _screenshotController.capture();
	String tempPath = (await getTemporaryDirectory()).path;
	File file = File('$tempPath/image.png');
	await file.writeAsBytes(uint8List!);
	await Share.shareFiles([file.path]);
  }
  
}
