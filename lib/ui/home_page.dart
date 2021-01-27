import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user/bloc/user_bloc.dart';
import 'package:github_user/bloc/user_event.dart';
import 'package:github_user/bloc/user_state.dart';
import 'package:github_user/model/user.dart';
import 'package:github_user/ui/profile_page.dart';

class Dash extends StatefulWidget {
  static String id = 'routeHome';

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
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

        if (state is UserInitial) {
          return Center(
            child: Text(
              'user initial',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (state is UserLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserError) {
          return AlertDialog(
            title: Text('Error status'),
            content: Text(state.errorMessage),
          );
        }

        return Container();
      }),
    );
  }
}
