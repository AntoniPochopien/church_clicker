import 'package:flutter/foundation.dart';

class AdId {
  static String get rewardedAdUnitId => kDebugMode
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-6326326366483871/7731033515';

  static String get bannerAdUnitId => kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-6326326366483871/9037096508';
}
