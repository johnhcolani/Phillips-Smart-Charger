
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:permission_handler/permission_handler.dart';



class PairingPage extends StatefulWidget {
  const PairingPage({super.key});

  @override
  _PairingPageState createState() => _PairingPageState();
}

class _PairingPageState extends State<PairingPage> {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  void Ble (){

  }

  List<ScanResult> _devicesList = [];
  BluetoothDevice? _connectedDevice;
  bool _isLoading = false;
  bool _isPairing =false;

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
    if(TargetPlatform.android == defaultTargetPlatform) {
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
      _isPairing = true;
    });

    // Pair with the selected device
    // await device.pair();

    // Discover the services offered by the device
    List<BluetoothService> services = await device.discoverServices();

    // Print out the characteristics and descriptors of each service
    for (BluetoothService service in services) {
      print('Service UUID: ${service.uuid}');
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print('Characteristic UUID: ${characteristic.uuid}');
        for (BluetoothDescriptor descriptor in characteristic.descriptors) {
          print('Descriptor UUID: ${descriptor.uuid}');
        }
      }
    }

    setState(() {
      _connectedDevice = device;
      _isPairing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (BuildContext context, int index) {
          final device = _devicesList[index].device;
          return ListTile(
            title: Text('Device Name:${device.name}' ?? ''),
            subtitle: Text('Device Id:${device.id.toString()}'),
            trailing: _connectedDevice == device
                ? const Text('Connected')
                : _isPairing
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () {
                _connectToDevice(device);
              },
              child: const Text('Pair'),
            ),
          );
        },
      ),
    );
  }
}
