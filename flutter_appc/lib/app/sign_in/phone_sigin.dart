import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appc/common_widgets/roundbuttom.dart';

class PhoneSignInPage extends StatefulWidget {
  @override
  _PhoneSignInPageState createState() => _PhoneSignInPageState();
}

class _PhoneSignInPageState extends State<PhoneSignInPage> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // width: size.width * 0.9,
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "เบอร์มือถือของคุณ",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'กรอกเบอร์มือถือของคุณ เพื่อเข้าใช้งาน',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  constraints: const BoxConstraints(maxWidth: 500),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CupertinoTextField(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    controller: phoneController,
                    clearButtonMode: OverlayVisibilityMode.editing,
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    placeholder: 'เบอร์มือถือ 10 หลัก',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedButton(
                    text: "เข้าใช้งาน",
                    press: () {
                      if (phoneController.text.isNotEmpty) {
                        String num = "+66" +
                            phoneController.text
                                .toString()
                                .substring(1, phoneController.text.length);
                        print(num);
                        // loginStore.getCodeWithPhoneNumber(context, num);
                      } else {
                        // loginStore.loginScaffoldKey.currentState
                        // ignore: deprecated_member_use
                        //     .showSnackBar(
                        //   SnackBar(
                        //     behavior: SnackBarBehavior.floating,
                        //     backgroundColor: Colors.red,
                        //     content: Text(
                        //       'กรุณากรอกหมายเลขให้ถูกต้อง',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                        // );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
