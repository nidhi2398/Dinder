import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/view/home_page_view.dart';
import 'package:untitled/view/swipe.dart';


Future<void> main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  HttpOverrides.global = MyHttpOverrides();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   // statusBarColor: Color(0xffb8082d),
    //     statusBarColor: Color(0xffdb234d),
    //   statusBarIconBrightness: Brightness.dark,
    //   systemNavigationBarColor: Colors.white,
    //   systemNavigationBarIconBrightness: Brightness.dark
    // ));
    FlutterNativeSplash.remove();

    return
    FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return ScreenUtilInit(
                designSize: const Size(375,812),
                minTextAdapt: true,
                builder: (ctx,child) => MaterialApp(
                  themeMode: ThemeMode.light,
                  darkTheme: ThemeData(
                    appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Color(0xffdb234d),
                            statusBarIconBrightness: Brightness.light
                        )
                    ),
                    primaryColor: const Color(0xffdb234d),
                    primaryColorLight: const Color(0xffe76684),
                    dialogBackgroundColor: const Color(0xfff8d9e1),
                    cardColor: const Color(0xffFFE8E8),
                    secondaryHeaderColor: const Color(0xfff5d5dd),
                    fontFamily: "Poppins",
                    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white10),
                  ),
                  debugShowCheckedModeBanner: false,
                  home: LoginScreen(),
                  // initialRoute: AppPages.INITIAL,
                  // getPages: AppPages.routes,

                  // initialBinding: Bindings.,
                )
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

  }
}



class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> host=="dinder.com"?true:false;
  }
}
