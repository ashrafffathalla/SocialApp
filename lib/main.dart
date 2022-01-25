import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/login/shoplogin_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:udemy_flutter/modules/shop_app/rigister/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop-app/shop_layout.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/social_app_rigister/cubit/cubit.dart';
import 'package:udemy_flutter/shared/bloc_observe.dart';
import 'package:udemy_flutter/layout/news-app/cubit/cubit.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constance.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cach_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/styles/themes.dart';
import 'modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// firebaseMessaging Background method

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on  Messaging Background');
  print(message.data.toString());
  showToast(text: 'on  Messaging Background', state: ToastStates.SUCCESS,);
}
void main()async
{
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //start send notifications
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.SUCCESS,);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on message OpenedApp');
    print(event.data.toString());
    showToast(text: 'on message OpenedApp', state: ToastStates.SUCCESS,);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  //end send notifications

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

    bool? isDark = CacheHelper.getData(key:'isDark');
    Widget? widget;
    //late bool onBoarding  = CacheHelper.getData(key:'onBoarding');
    //token= CacheHelper.getData(key:'token');
     uId= CacheHelper.getData(key:'uId');

// if(onBoarding != null)
//   {
//     if(token != null) widget =const ShopLayout();
//     else widget = ShopLoginScreen();
//
//   }
//   else {
//   widget = OnBoardingScreen();
// }
  if(uId !=null)
    {
      widget = const SocialLayout();
    }
  else{
    widget = SocialLogin();
  }
  runApp( MyApp(
      isDark,
   widget,
  ));
}
//  stateless
//  Stateful
// class MyAPP
class MyApp extends StatelessWidget

{
     bool? isDark;
     Widget? startWidget;

    MyApp(this.isDark,this.startWidget,{Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),
        ),
    BlocProvider(
    create: (BuildContext context) =>AppCubit()..changeAppMode(
    fromShared: isDark,
    ),
    ),
        BlocProvider(
          create: (BuildContext context) =>ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
    BlocProvider(
    create: (BuildContext context)=> ShopRegisterCubit(),
    ),
    BlocProvider(
        create: (BuildContext context) => SocialRegisterCubit(),
    ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],

        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){},
          builder: (context, state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
              home: startWidget,
            );
          },
        ),
      );

  }
  }

