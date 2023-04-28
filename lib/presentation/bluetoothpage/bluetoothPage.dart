import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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
late String deviceName;
late String deviceId;
  List<ScanResult> _devicesList = [];
  BluetoothDevice? _connectedDevice;
  bool _isLoading = false;
  final bool _isPairing = false;
  Timer? _timer;

  get device => _connectedDevice;



  @override
  void initState() {
    _startDiscovery();
    _flutterBlue.startScan();
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
    //deviceName=device.name;

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
    StreamSubscription<ScanResult> _scanSubscription;
    _flutterBlue.scanResults.listen((scanResults) {
      var filteredResults = scanResults
          .where((result) => result.device.name.contains("Phillips"))
          .toList();
      print("Found ${filteredResults.length} devices with name Phillips");
      setState(() {
        _devicesList = scanResults;
      });
    });

    _flutterBlue.startScan(timeout: const Duration(seconds: 4));

    setState(() {
      _isLoading = false;
    });
  }

  void disconnectFromDevice() {}

  void _connectToDevice(BluetoothDevice device) async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Connect to the selected device
      await device.connect(timeout: const Duration(seconds: 8));
      showToast("Device connected successfully!");

      //await device.pair();
      // Discover the services offered by the device
      List<BluetoothService> services = await device.discoverServices();

      // Print out the characteristics and descriptors of each service
      for (BluetoothService service in services) {
        print('Service UUID: ${service.uuid}');
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
            print('Characteristic UUID: ${characteristic.uuid}');
            print('Characteristic DEVICE ID: ${characteristic.deviceId}');
            print('Characteristic VALUE: ${characteristic.value}');
          for (BluetoothDescriptor descriptor in characteristic.descriptors) {
            print('Descriptor UUID: ${descriptor.uuid}');
            print('Descriptor DEVICE ID: ${descriptor.deviceId}');
            print('Descriptor VALUE: ${descriptor.value}');
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
      showToast("Connection timed out!");

      print('Connection timed out');
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showToast("Error connecting to device: $e!");

      print('Error connecting to device: $e');
    }
  }

  void _rescan() {
    _flutterBlue.stopScan();
    _devicesList.clear();

    setState(() {
      _isLoading = true;
    });
    _flutterBlue.scanResults.listen((scanResult) {
      setState(() {
        _devicesList = scanResult
            .where((result) => result.device != _connectedDevice)
            .toList();
      });
    });
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double he = MediaQuery.of(context).size.height;
    double wi = MediaQuery.of(context).size.width;
    return Scaffold(

        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(children: [
        const AppBackground(),
        Padding(
          padding: const EdgeInsets.only(top: 28.0),
          child: Column(
            children: [
              const SizedBox(
                height: AppSize.s48,
              ),
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/phillips_logo.png"),
                        fit: BoxFit.fill)),
                height: 4.h,
                width: 18.h,
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              Text(
                ' Pair Smart Charger',
                style: GoogleFonts.orbitron(
                  textStyle: TextStyle(
                      color: ColorManager.panMotorSport, fontSize: AppSize.s24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppPadding.p16),
                child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(const Color(0xff001F4C)),
                    ),
                    onPressed: () {
                      _rescan();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: AppPadding.p24,
                          right: AppPadding.p24,
                          top: AppPadding.p4,
                          bottom: AppPadding.p4),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'SCAN Nearby Smart Charger',
                          style: TextStyle(
                              fontSize: AppSize.s18, color: ColorManager.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: AppSize.s16,
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_connectedDevice != null)
                    Text(
                      'Connected Device: ${_connectedDevice!.name}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  if (_connectedDevice != null)
                    IconButton(
                        onPressed: () async {
                          await device.disconnect();
                          setState(() {
                            _connectedDevice = null;
                          });
                          showToast('Device Disconnected Successfully');
                        },
                        icon: Icon(
                          Icons.bluetooth_disabled,
                          color: Colors.green.shade500,
                        ))
                ],
              ),
              const SizedBox(
                height: AppSize.s16,
              ),

              Container(
                color: ColorManager.whiteOpacity30,
                height: AppSize.s1_5,
              ),
              const SizedBox(
                height: AppSize.s16,
              ),
              Text(
                ' Click on the Smart Charger you want to connect',
                style: TextStyle(
                    fontFamily: 'Trade_Gothic',
                    //fontStyle: FontStyle.italic,
                    color: ColorManager.white,
                    fontSize: AppSize.s14),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: _devicesList
                            .where((device) =>

                                    device.device.name.contains("ESP") ||
                                device.device.name.contains("Phillips"))
                            .length,
                        //itemCount: _devicesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final device = _devicesList
                              .where((device) =>

                                      device.device.name.contains("ESP") ||
                                  device.device.name.contains("Phillips"))
                              .toList()[index]
                              .device;
                           //final device = _devicesList[index].device;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                        ? IconButton(
                                            onPressed: () {
                                              _connectToDevice(device);
                                              _startDelay();
                                            },
                                            icon: Icon(
                                              Icons.bluetooth_connected,
                                              color: Colors.green.shade500,
                                            ),
                                          )
                                        : _isPairing
                                            ? const CircularProgressIndicator()
                                            : IconButton(

                                      color: const Color(0xff063348),
                                                onPressed: () {
                                                  _connectToDevice(device);
                                                  _startDelay();
                                                },
                                                icon: const Icon(

                                                  Icons.bluetooth,
                                                  color: Colors.white,
                                                ),
                                              ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ]),
    ));
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomeView(
                  deviceName: _connectedDevice!.name,
                  idNumber: _connectedDevice!.id.toString(),
                )));
    // '/MyApp'; (context) => const MyApp();
  }
}

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor:  const Color(0xff002F6C ),
      textColor: Colors.white,
      timeInSecForIosWeb: 2,
      fontSize: 16.0);
}


// Padding(
//   padding: const EdgeInsets.only(top: AppPadding.p16),
//   child: OutlinedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(
//             const Color(0xff0076A8)),
//       ),
//       onPressed: () {
//         _rescan();
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(
//             left: AppPadding.p24,
//             right: AppPadding.p24,
//             top: AppPadding.p4,
//             bottom: AppPadding.p4),
//         child: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Text(
//             'RESCAN',
//             style: TextStyle(
//                 fontSize: AppSize.s18,
//                 color: ColorManager.white),
//           ),
//         ),
//       )),
// ),