import 'package:church_clicker/consts/ads_id.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAdsService {
  static final GoogleAdsService _googleAdsService =
      GoogleAdsService._internal();

  factory GoogleAdsService() {
    return _googleAdsService;
  }

  GoogleAdsService._internal();

  RewardedAd? rewardedAd;

  void createRewardedAd() {
    RewardedAd.load(
      adUnitId: AdId.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => rewardedAd = ad,
        onAdFailedToLoad: (error) => rewardedAd = null,
      ),
    );
  }

  void showRewardedAd({required Function onEarnRewardCallback}) {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createRewardedAd();
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (ad, reward) => onEarnRewardCallback(),
      );
    }
  }
}
