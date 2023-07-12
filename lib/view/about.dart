import 'package:flutter/material.dart';
import 'package:p01/utils/global.colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: Container(
          padding: const EdgeInsets.all(8),
          child: const Text('About Us'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Eyes Up',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                        width: 500,
                        padding: EdgeInsets.all(8),
                        child: Text(
                          """
        Selamat datang di Eyes Up! Kami adalah aplikasi revolusioner yang bertujuan untuk memberikan bantuan kepada orang tunanetra dengan cara menghubungkan mereka dengan sukarelawan yang dengan senang hati berperan sebagai alat visual mereka.

        Kami di Eyes Up percaya bahwa setiap orang berhak merasakan keindahan dunia di sekitar mereka. Melalui aplikasi kami, kami menghubungkan orang tunanetra dengan sukarelawan yang peduli, menciptakan pengalaman visual yang luar biasa bagi mereka.

        Kami berkomitmen untuk membangun komunitas inklusif dan empati di dalam Eyes Up. Dengan kerjasama antara orang tunanetra dan sukarelawan, kami menciptakan hubungan yang saling mendukung dan memungkinkan aksesibilitas yang lebih besar bagi mereka.

        Di balik Eyes Up, terdapat tim yang penuh semangat, terdiri dari pengembang, desainer, dan sukarelawan yang berdedikasi. Bersama-sama, kami menghadirkan teknologi dan kebaikan hati untuk mengubah kehidupan orang tunanetra.

        Melalui aplikasi Eyes Up, kami ingin mengubah cara orang tunanetra menjalani kehidupan sehari-hari. Kami percaya bahwa dengan bantuan sukarelawan sebagai "mata" mereka, mereka dapat merasakan kebebasan dan kepercayaan diri yang lebih besar dalam menjelajahi dunia.

        Kami di Eyes Up mengutamakan keamanan dan kerahasiaan data. Kami menjaga privasi semua pengguna kami dengan ketat, sehingga Anda dapat merasa aman dan nyaman menggunakan aplikasi kami.

        Kami mengundang Anda untuk bergabung dengan komunitas Eyes Up dan menjadi sukarelawan yang berperan penting dalam perubahan positif dalam kehidupan orang tunanetra. Setiap kontribusi Anda sangat berarti dan dapat membuat perbedaan yang besar.

""",
                          style: TextStyle(
                              fontSize: 14, wordSpacing: 3, height: 1.5),
                          textAlign: TextAlign.justify,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Text(
                "Eyes Up est.2023",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
