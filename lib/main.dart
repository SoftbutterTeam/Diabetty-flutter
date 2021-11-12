import 'dart:io';

import 'package:diabetty/blocs/dayplan_manager.dart';
import 'package:diabetty/blocs/diary.bloc.dart';
import 'package:diabetty/blocs/therapy_manager.dart';
import 'package:diabetty/models/therapy/therapy.model.dart';
import 'package:diabetty/routes.dart' as routerthing;
import 'package:diabetty/ui/common_widgets/scroll_behaviours/SBehavior.dart';
import 'dart:ui';

import 'package:device_info/device_info.dart';
import 'package:diabetty/utils/notifcation._service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:diabetty/ui/constants/colors.dart';
import 'package:diabetty/ui/layouts/dashboard.layout.dart';
import 'package:diabetty/ui/screens/others/loading_screens/loading.screen.dart';
import 'package:provider/provider.dart';
import 'package:diabetty/utils/application_state_reset_timer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: appWhite));

  NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    TherapyManager therapyManager = TherapyManager()..init();
    DiaryBloc diaryBloc = DiaryBloc()..init();
    DayPlanManager dayPlanManager = DayPlanManager()..init(therapyManager);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TherapyManager>(
            create: (_) => therapyManager,
          ),
          ChangeNotifierProvider<DayPlanManager>(
            create: (_) => dayPlanManager,
          ),
          ChangeNotifierProvider<DiaryBloc>(
            create: (_) => diaryBloc,
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: routerthing.Router.generateRoute,
            home: DashBoard(
              initIndex: 1,
            ),
            builder: (context, child) {
              startKeepAlive(dayPlanManager.refresh);
              return FutureBuilder(
                future: () async {
                  await dayPlanManager.init(therapyManager);
                  await Future.delayed(
                      const Duration(milliseconds: 1000), () {});
                  return;
                }.call(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return LoadingScreen();
                  return ScrollConfiguration(
                    behavior: SBehavior(),
                    child: child,
                  );
                },
              );
            }));
  }
}
