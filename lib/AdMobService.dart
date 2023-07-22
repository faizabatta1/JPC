import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111';
    }

    return null;
  }

  static final BannerAdListener bannerListener = BannerAdListener(
    onAdLoaded: (ad) => print('a live'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      print('closing add failure');
    },
    onAdOpened: (ad) => print('opened'),
    onAdClosed: (ad) => print('closed')
  );

}