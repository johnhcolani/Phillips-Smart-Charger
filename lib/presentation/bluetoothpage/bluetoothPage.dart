import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phillips_smart_charger/presentation/resources/color_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/font_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../homeview/home_view.dart';
import '../resources/app_background.dart';
import '../resources/style_manager.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  List<ScanResult> _devicesList = [];
  BluetoothDevice? _connectedDevice;
  bool _isLoading = false;
  bool _isPairing = false;
  Timer? _timer;

  @override
  void initState() {
    _startDiscovery();
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
    _requestLocationPermission();
    _flutterBlue.stopScan();
    super.initState();
  }

  void _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle permission denied
    }
  }

  void _startDiscovery() async {
    if (TargetPlatform.android == defaultTargetPlatform) {
      final status = await Permission.location.request();
      if (status != PermissionStatus.granted) {
        // handle the case where the user did not grant location permission
        return;
      }
    }
    setState(() {
      _isLoading = true;
    });

    // Start scanning for nearby devices
    _flutterBlue.scanResults.listen((scanResults) {
      // var filteredResults = scanResults.where((result) => result.device.name == "GoCube").toList();
      // print("Found ${filteredResults.length} devices with name gocube");
      setState(() {
        _devicesList = scanResults;
      });
    });

    _flutterBlue.startScan(timeout: Duration(seconds: 4));

    setState(() {
      _isLoading = false;
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Connect to the selected device
      await device.connect(timeout: const Duration(seconds: 4));
      Fluttertoast.showToast(
          msg: "Device connected successfuly!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: ColorManager.panConnect,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      //await device.pair();
      // Discover the services offered by the device
      List<BluetoothService> services = await device.discoverServices();

      // Print out the characteristics and descriptors of each service
      for (BluetoothService service in services) {
        print('Service UUID: ${service.uuid}');
        for (BluetoothCharacteristic characteristic
        in service.characteristics) {
          print('Characteristic UUID: ${characteristic.uuid}');
          for (BluetoothDescriptor descriptor in characteristic.descriptors) {
            print('Descriptor UUID: ${descriptor.uuid}');
          }
        }
      }

      setState(() {
        _connectedDevice = device;
        _isLoading = false;
      });
    } on TimeoutException catch (_) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Connection timed out!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.blue,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Connection timed out');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Error connecting to device: $e!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorManager.panConnect,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
      print('Error connecting to device: $e');
    }

  }


  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Bluetooth Devices'),
        // ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(children: [
        const AppBackground(),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _devicesList
                    .where((device) => device.device.name == "GoCube_92AB5A_1")
                    .length,
                //itemCount: _devicesList.length,
                itemBuilder: (BuildContext context, int index) {
                  final device = _devicesList
                      .where(
                          (device) => device.device.name == "GoCube_92AB5A_1")
                      .toList()[index]
                      .device;
                  // final device = _devicesList[index].device;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                     // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: AppSize.s40,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/phillips_logo.png"),
                                  fit: BoxFit.fill)),
                          height: 5.h,
                          width: 24.h,
                        ),
                        const SizedBox(
                          height: AppSize.s24,
                        ),
                        Text(
                          ' Pair Smart Charger',
                          style: TextStyle(
                              fontFamily: 'Trade_Gothic',
                              //fontStyle: FontStyle.italic,
                              color: ColorManager.whiteOpacity70,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: AppSize.s24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppPadding.p32),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff0076A8)),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: AppPadding.p24,
                                    right: AppPadding.p24,
                                    top: AppPadding.p4,
                                    bottom: AppPadding.p4),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    'RESCAN',
                                    style: TextStyle(
                                        fontSize: AppSize.s18,
                                        color: ColorManager.white),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          color: ColorManager.whiteOpacity30,
                          height: AppSize.s1_5,
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: ColorManager.whiteOpacity50),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: ListTile(
                            title: Text(
                              '${device.name}' ?? '',
                              style: getSemiBoldStyle(
                                  fontSize: FontSize.s18,
                                  color: ColorManager.white),
                            ),
                            subtitle: Text(
                              'Id:${device.id.toString()}',
                              style: getSemiBoldStyle(
                                  fontSize: 14.0,
                                  color: ColorManager.panSLightBlue),
                            ),
                            trailing: _connectedDevice == device
                                ? Text(
                                    'Connected',
                                    style: TextStyle(
                                        color: ColorManager.whiteOpacity70),
                                  )
                                : _isPairing
                                    ? const CircularProgressIndicator()
                                    : TextButton(
                                        onPressed: () {
                                          _connectToDevice(device);
                                          _startDelay();
                                        },
                                        child: Text(
                                          'Pair',
                                          style: TextStyle(
                                              color:
                                                  ColorManager.whiteOpacity70),

                                          // ? ElevatedButton(
                                          //     child: const Text('Connected /Disconnect'),
                                          //     onPressed: () async {
                                          //       await _connectedDevice!.disconnect();
                                          //       Fluttertoast.showToast(
                                          //           msg: "Device disconnected successfully!",
                                          //           toastLength: Toast.LENGTH_SHORT,
                                          //           gravity: ToastGravity.CENTER,
                                          //           backgroundColor: ColorManager.panConnect,
                                          //           timeInSecForIosWeb: 1,
                                          //           textColor: Colors.white,
                                          //           fontSize: 16.0);
                                          //       setState(() {
                                          //         _connectedDevice = null;
                                          //       });
                                          //     },
                                          //   )
                                          // : ElevatedButton(
                                          //     onPressed: () {
                                          //       _connectToDevice(device);
                                          //     },
                                          //     child: const Text('Connect'),
                                          //   ),
                                        ),
                                      ),
                          ),
                        ),
                        Column(
                          children: [

                            // Padding(
                            //   padding: const EdgeInsets.only(top: AppPadding.p20),
                            //   child: OutlinedButton(
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty.all(
                            //             const Color(0xff002F6C)),
                            //       ),
                            //       onPressed: () {},
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(
                            //             left: AppPadding.p60,
                            //             right: AppPadding.p60,
                            //             top: AppPadding.p8,
                            //             bottom: AppPadding.p8),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(6.0),
                            //           child: Text(
                            //             'Saved Device ID',
                            //             style: TextStyle(
                            //                 fontSize: AppSize.s18,
                            //                 color: ColorManager.white),
                            //           ),
                            //         ),
                            //       )),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: AppPadding.p20),
                            //   child: OutlinedButton(
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty.all(
                            //             const Color(0xff002F6C)),
                            //       ),
                            //       onPressed: () {},
                            //       child: Padding(
                            //         padding: const EdgeInsets.only(
                            //             left: AppPadding.p60,
                            //             right: AppPadding.p60,
                            //             top: AppPadding.p8,
                            //             bottom: AppPadding.p8),
                            //         child: Padding(
                            //           padding: const EdgeInsets.all(6.0),
                            //           child: Text(
                            //             '  Forget Device  ',
                            //             style: TextStyle(
                            //                 fontSize: AppSize.s18,
                            //                 color: ColorManager.white),
                            //           ),
                            //         ),
                            //       )),
                            // )
                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),
      ]),
    ));
  }
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  const HomeView()));
    // '/MyApp'; (context) => const MyApp();
  }
}


