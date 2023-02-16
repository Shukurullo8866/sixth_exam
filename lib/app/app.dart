import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_exam/cubit/connectivity/connectivity_cubit.dart';
import 'package:sixth_exam/data/get_It/my_locator.dart';
import 'package:sixth_exam/data/repositories/code_repositories.dart';
import 'package:sixth_exam/data/repositories/notification_repo.dart';
import 'package:sixth_exam/data/servise/api_servise.dart';

import '../bloc/local_data_cacht/cached_bloc.dart';
import '../cubit/api_multi_state_cubit/multi_state_cubit.dart';
import '../cubit/api_single_state_cubit/single_state_cubit.dart';
import '../screens/tab_box/tab_box.dart';
import '../servise/local_notification.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CodeRepositories(apiService: myLocator<ApiService>())),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => AUDStateBloc(
          //     ContactRepository(),
          //   ),
          // ),
          // BlocProvider(
          //   create: (context) => GetUserContactsCubit(
          //     userContactRepository: ContactRepository(),
          //   ),

          BlocProvider(
            create: (context) =>
                MessegeBloc(notificationRepository: NotificationRepository()),
          ),
          BlocProvider(
            create: (context) => ConnectivityCubit(),
          ),
          BlocProvider(
            create: (context) => SingleStateCubit(
                codeRepository: CodeRepositories(apiService: ApiService())),
          ),
          BlocProvider(
            create: (context) => MultiStateCubit(
                codeRepositories: CodeRepositories(apiService: ApiService())),
          ),
        ],
        child: MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabBox(),
      navigatorKey: navigatorKey,
    );
  }
}
