import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_router.dart';
import 'package:flutter/material.dart';

void main() {
   runApp(
         DevicePreview(builder: (context) {
           return RickAndMortyApp(appRouter: AppRouter());
  },
  ),
  );
  }
 


class RickAndMortyApp extends StatelessWidget {
final AppRouter appRouter;       

   const RickAndMortyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
         
          debugShowCheckedModeBanner: false,
           onGenerateRoute: AppRouter().generateRoute,
        );
      },

  }

  