import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soical/layout/layoutHome/LayoutHome.dart';
import 'package:soical/layout/layoutHome/cubit/cubit.dart';
import 'package:soical/model/login/login.dart';
import 'package:soical/shared/SharedPreferences/SharedPreferences.dart';
import 'package:soical/shared/constant/constant.dart';
import 'shared/blocobserve/blocobserve.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = const SimpleBlocObserver();
  await Preference.init();
   uid=  Preference.getData(key: 'uid');
  // uidR= Preference.getData(key: 'uidR');
   if (kDebugMode) {
     print("main uid $uid");
   }

  Widget firstWidget;
  if(uid != null){
    firstWidget=const LayoutSocial();
  }else{
    firstWidget=SocialLogin();
  }


  runApp( MyApp(firstWidget: firstWidget,));
}

class MyApp extends StatelessWidget {
  final Widget firstWidget;
   const MyApp({super.key, required this.firstWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>CubitLayoutSocial()..getUser()..getNewPost(context)),
      ],
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto Italic',
          primarySwatch:Colors.teal,
          appBarTheme: AppBarTheme(
            backgroundColor:Theme.of(context).scaffoldBackgroundColor,
            elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.teal
          ),
            titleTextStyle: TextStyle(
                color: Colors.teal.shade400,
                fontSize: 27.0,
              fontFamily: 'Roboto Italic',
            ),
            actionsIconTheme: const IconThemeData(color: Colors.black),
          ),
        ),

        home: firstWidget,
      ),
    );
  }
}

