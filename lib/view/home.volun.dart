// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:p01/utils/global.colors.dart';
import 'package:provider/provider.dart';
import '../providers/prov.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeVolun extends StatefulWidget {
  const HomeVolun({Key? key}) : super(key: key);

  @override
  _HomeVolunState createState() => _HomeVolunState();
}

class _HomeVolunState extends State<HomeVolun> {
  String currentLocation = ''; // Default location text
  late BannerAd _bannerAd;
    bool _isBannerReady = false;
    void initState() {
      super.initState();
      _initializeBannerAd();
    }
   @override
  void dispose() {
    _disposeBannerAd();
    super.dispose();
  }
  void _disposeBannerAd() {
    _bannerAd.dispose();
    _isBannerReady = false;
}
  void _initializeBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-3940256099942544/6300978111", // Replace with your ad unit ID
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) {
            setState(() {
              _isBannerReady = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          _disposeBannerAd();
        },
      ),
      request: AdRequest(),
    );
    _bannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    final userFirstName = Provider.of<Prov>(context).userFirstName;
    final userLastName = Provider.of<Prov>(context).userLastName;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFF4),
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 50,
              width: 50,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text('Eyes Up'),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 75,
            top: 10,
            width: 250,
            height: 70,
            child: Container(
              width: 250,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 140,
            top: 20,
            child: Text(
              '  $userFirstName $userLastName',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Positioned(
            left: 125,
            top: 45,
            child: Text(
              'member since Apr 2023',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          const Positioned(
            left: 100,
            top: 100,
            child: Text(
              'You will receive a notification \nwhen someone needs your help.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF0E4189),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 145,
            child: ElevatedButton(
              onPressed: () async {
                // Memeriksa izin lokasi
                var status = await Permission.location.status;
                if (status.isDenied || status.isRestricted) {
                  // Meminta izin lokasi jika belum diizinkan
                  await Permission.location.request();
                } else {
                  // Izin lokasi sudah diberikan, dapatkan lokasi dan perbarui teks
                  Position position = await Geolocator.getCurrentPosition();

                  // Use geocoding to get the country from the coordinates
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    position.latitude,
                    position.longitude,
                  );

                  if (placemarks.isNotEmpty) {
                    setState(() {
                      currentLocation =
                          placemarks[0].country ?? 'Unknown Country';
                    });
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF0E4189)),
              ),
              child: Text('Your current location: $currentLocation'),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(height: 60),
                ButtonVCvolun(),
                SizedBox(height: 20),
                Text(
                  'Click the button to start helping!',
                  style: TextStyle(
                    color: Color(0xFF707D93),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
                child: _isBannerReady
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: _bannerAd.size.width.toDouble(),
                          height: _bannerAd.size.height.toDouble(),
                          child: AdWidget(ad: _bannerAd),
                        ),
                      )
                    : Container())
        ],
      ),
    );
  }
}
