import 'dart:developer';

import 'package:church_clicker/consts/ad_id.dart';
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

  Future<void> consentInfo() async {
    ConsentInformation.instance
        .requestConsentInfoUpdate(ConsentRequestParameters(), () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        await loadForm();
      }
    }, (error) {
      log('consentInfo error ${error.message}');
    });
  }

  Future<void> loadForm() async {
    try {
      ConsentForm.loadConsentForm(
        (ConsentForm consentForm) async {
          var status = await ConsentInformation.instance.getConsentStatus();
          if (status == ConsentStatus.required) {
            consentForm.show(
              (formError) {
                loadForm();
              },
            );
          }
        },
        (FormError formError) {
          log('loadConsentForm error ${formError.message}');
        },
      );
    } catch (e) {
      log('Load rodo form error $e');
    }
  }

  Future<void> resetConsent() async {
    ConsentInformation.instance
        .requestConsentInfoUpdate(ConsentRequestParameters(), () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        await loadFormAgain();
      }
    }, (error) {
      log('resetConsent error ${error.message}');
    });
  }

  Future<void> loadFormAgain() async {
    ConsentForm.loadConsentForm(
      (ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        if (status == ConsentStatus.notRequired ||
            status == ConsentStatus.obtained) {
          consentForm.show(
            (formError) {
              log('consentForm show error $formError');
            },
          );
        }
      },
      (FormError formError) {
        log('loadFormAgain error ${formError.message}');
      },
    );
  }
}
