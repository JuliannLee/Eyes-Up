import 'package:flutter/material.dart';
import 'package:p01/view/widgets/button.global.dart';
import 'package:p01/view/widgets/text.form.global.dart';

class ForgetView extends StatelessWidget {
  ForgetView({ Key? key }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/logo.png', width: 200, height: 200),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Input your email',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 15),

                //email input
                TextFormGlobal1(
                  controller: emailController, 
                  text: 'Email', 
                  obscure: false, 
                  textInputType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 10),
                const ButtonGlobal3(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}