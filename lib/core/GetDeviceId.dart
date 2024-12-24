import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

Future<String?> getDeviceIdentifier() async {
  String? deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceIdentifier = androidInfo.id;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceIdentifier = iosInfo.identifierForVendor;
  } 
  return deviceIdentifier;
}
