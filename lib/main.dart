import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/bloc/user_bloc.dart';

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
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          BlocProvider.of<UserBloc>(context).add(FetchUsers());
        },
        child: CircleAvatar(
          backgroundColor: Colors.lightBlue,
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadSuccess) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserLoadSuccess) {
          return Text('we have users now');
        }

        if (state is UserError) {
          return Text(state.errorMessage);
        }

        return Center(
          child: Text('no user yet'),
        );
      }),
    );
  }
}
