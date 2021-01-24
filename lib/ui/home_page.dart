import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/bloc/user_bloc.dart';
import 'package:github_user/bloc/user_event.dart';
import 'package:github_user/bloc/user_state.dart';
import 'package:github_user/model/user.dart';
import 'package:github_user/ui/profile_page.dart';

class HomePage extends StatefulWidget {
  static String id = 'routeHome';

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
      appBar: AppBar(
        title: Text('Github User'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: CircleAvatar(
          backgroundColor: Colors.lightBlue,
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserLoadSuccess) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final User user = state.users[index];
              return ListTile(
                onTap: () => Navigator.pushNamed(context, ProfilePage.id,
                    arguments: user),
                title: Text('${user.name}'),
                subtitle: Text('${user.id}'),
                leading: CachedNetworkImage(
                  imageUrl: user.imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return CircularProgressIndicator(
                        value: downloadProgress.progress);
                  },
                ),
              );
            },
          );
        }

        if (state is UserError) {
          // return Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Card(
          //       color: Colors.black,
          //       child: Padding(
          //         padding: const EdgeInsets.all(16.0),
          //         child: Column(
          //           children: [
          //             Center(
          //               child: Text(
          //                 state.errorMessage,
          //                 style: TextStyle(fontSize: 25, color: Colors.white),
          //               ),
          //             ),
          //             RaisedButton(
          //               child: Text('Retry'),
          //               onPressed: () {
          //                 BlocProvider.of<UserBloc>(context)
          //                     .add(FetchGitUsers());
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // );

          return AlertDialog(
            title: Text(state.errorMessage),
            actions: [
              FlatButton(
                color: Colors.black,
                child: Text('Retry'),
                onPressed: () {
                  BlocProvider.of<UserBloc>(context).add(FetchGitUsers());
                },
              )
            ],
          );
        }
        if (state is UserInitial) {
          return Center(
            child: Text(
              'user initial',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return null;
      }),
    );
  }
}
