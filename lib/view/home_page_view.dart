import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/primaryBg.png'),
                fit: BoxFit.cover,
              )),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 200,
                  left: 59,
                  child: Container(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 48,
                          fontFamily: 'Poppins-Medium',
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  )),
              Positioned(top: 290, right: 0, bottom: 0, child: Container(
                width: MediaQuery.of(context).size.width,
                height: 654,
                decoration: BoxDecoration(
                  color: Color(0x80FFFFFF),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0),
                      bottomRight: Radius.circular(60.0)
                  ),
                ),
              )),
              Positioned(top: 318, right: 0, bottom: 28, child: Container(
                width: 399,
                height: 584,
                decoration: BoxDecoration(
                  color: Color(0xFFE9FFF6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60.0),
                    bottomRight: Radius.circular(60.0),
                    bottomLeft: Radius.circular(60.0),
                  ),
                ),
              )),
              Positioned(top: 320, right: 0, bottom: 48, child: Container(
                height: 584,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 59,
                      top: 99,
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                        left: 59,
                        top: 129,
                        child: Container(
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Enter User ID or Email',
                              hintStyle: TextStyle(color: Color(0xFFB4B4B4)),
                            ),
                          ),
                        )),
                    Positioned(
                      left: 59,
                      top: 199,
                      child: Text(
                        'Password',
                        style: TextStyle(
                            fontFamily: 'Poppins-Medium',
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                        left: 59,
                        top: 229,
                        child: Container(
                          width: 310,
                          child: TextField(
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(color: Color(0xFFB4B4B4)),
                            ),
                          ),
                        )),
                    Positioned(
                        right: 60,
                        top: 296,
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color(0xFF024335),
                              fontSize: 16,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w600),
                        )),
                    Positioned(
                        left: 46,
                        top: 361,
                        child: Checkbox(
                          checkColor: Colors.black,
                          activeColor: Color(0xFF024335),
                          value: isChecked,
                          onChanged: (bool? value) {
                            isChecked = value!;
                          },
                        )),
                    Positioned(
                        left: 87,
                        top: 375,
                        child: Text(
                          'Remember Me',
                          style: TextStyle(
                              color: Color(0xFF024335),
                              fontSize: 16,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.w500),
                        )),
                    Positioned(
                        top: 365,
                        right: 60,
                        child: Container(
                          width: 99,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(0xFF024335),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Poppins-Medium',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 432,
                        left: 59,
                        child: Container(
                          height: 0.5,
                          width: 310,
                          color: Color(0xFF707070),
                        )),
                    Positioned(
                        top: 482,
                        left: 120,
                        right: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 59,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF024335)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Image.asset(
                                'images/icon_google.png',
                                width: 20,
                                height: 21,
                              ),
                            ),
                            Text(
                              'or',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Poppins-Regular',
                                  color: Color(0xFFB4B4B4)),
                            ),
                            Container(
                              width: 59,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF024335)),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Image.asset(
                                'images/icon_apple.png',
                                width: 20,
                                height: 21,
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              )),
            ],
          ),
        ),
      )
      // Scaffold(
      //   body: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(16),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text("My App" , style: TextStyle(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold),),
      //             Text("Login", style: TextStyle(color: Colors.black, fontSize: 44, fontWeight: FontWeight.bold),),
      //             SizedBox(height: 44,),
      //             TextField(
      //               keyboardType: TextInputType.emailAddress,
      //               decoration: const InputDecoration(
      //                 hintText: "User Email",
      //                 prefixIcon: Icon(Icons.mail, color: Colors.black),
      //               ),
      //             ),
      //             SizedBox(
      //               height: 26,
      //             ),
      //             TextField(
      //               obscureText: true,
      //               decoration: const InputDecoration(
      //                 hintText: "User Password",
      //                 prefixIcon: Icon(Icons.lock, color: Colors.black),
      //               ),
      //             ),
      //             Text("Don't Remember your Password?", style: (TextStyle(color: Colors.blue)),),
      //             SizedBox(height: 88,),
      //             Container(
      //               width: double.infinity,
      //               child: RawMaterialButton(
      //                 fillColor: Color(0xff0069fe),
      //                 elevation: 0.0,
      //                 padding: EdgeInsets.symmetric(vertical: 20),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //                 onPressed: (){
      //
      //                 },
      //                 child: Text(
      //                   "Login" , style: TextStyle(color: Colors.white,fontSize: 18),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}