import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/ui/home_page.dart';
import 'package:github_user/ui/profile_page.dart';

import 'bloc/user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          ProfilePage.id: (context) => ProfilePage()
        },
      ),
    );
  }
}
