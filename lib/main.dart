import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/bloc/user_bloc.dart';
import 'package:github_user/bloc/user_event.dart';
import 'package:github_user/ui/home_page.dart';
import 'package:github_user/ui/profile_page.dart';

import 'bloc/user_bloc.dart';
import 'model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          Dash.id: (context) => Dash(),
          ProfilePage.id: (context) => ProfilePage()
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static String id = 'routeId';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(FetchGitUsers());
  }

  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            BlocProvider.of<UserBloc>(context).add(FetchGitUsers());
          },
          child: CircleAvatar(
            backgroundColor: Colors.lightBlue,
          ),
        ),
        body: Dash());
  }
}

Widget userDetails(User user) {
  return ListTile(
    leading: Image(
      image: NetworkImage(user.imageUrl),
      fit: BoxFit.cover,
      height: 30,
    ),
    title: Text(user.name),
  );
}

//
// SafeArea(
// child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
// if (state is UserLoadSuccess) {
// if (state.users.length == 0) {
// return Center(
// child: Text('empty data'),
// );
// }
// return Container(
// height: double.infinity,
// width: double.infinity,
// child: ListView(
// children: state.users
//     .map((e) => Card(
// margin: EdgeInsets.symmetric(vertical: 10),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(5)),
// child: ListTile(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ProfilePage(
// user: e,
// )));
// },
// leading: CachedNetworkImage(
// progressIndicatorBuilder:
// (context, ydsu, dlP) {
// return CircularProgressIndicator();
// },
// imageUrl: e.imageUrl,
// fit: BoxFit.contain,
// ),
// title: Text(e.name.toUpperCase())),
// ))
//     .toList()),
// );
// }
//
// if (state is UserError) {
// return Text(state.errorMessage);
// }
// if (state is UserLoadInProgress) {
// return Center(
// child: CircularProgressIndicator(),
// );
// }
// return Center(
// child: Text('no user yet'),
// );
// }),
// ),
