import 'package:firebase_admob/firebase_admob.dart';

class AdvertService {
  static final AdvertService _instance = AdvertService._internal();
  factory AdvertService()=>_instance;
  MobileAdTargetingInfo _targetingInfo;
  final String _bannerAd="";
  final String _gecisAd="";
  AdvertService._internal(){
_targetingInfo = MobileAdTargetingInfo();


}
showBanner(){
    BannerAd banner = BannerAd(
      adUnitId:BannerAd.testAdUnitId,//_bannerAd,
      size: AdSize.smartBanner,
      targetingInfo: _targetingInfo,
    );
    banner..load()
    ..show();
    banner.dispose();
}
showInters(){
    InterstitialAd interstitialAd = InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,//_gecisAd,
      targetingInfo: _targetingInfo,
    );
    interstitialAd
      ..load()
      ..show();
    interstitialAd.dispose();
}

}