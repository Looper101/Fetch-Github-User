import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
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
            child: SpinKitFadingCircle(
              size: 50,
              color: Colors.teal,
            ),
          );
        }
        if (state is UserError) {
          return Stack(
            children: [
              AlertDialog(
                title: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text('Error')
                  ],
                ),
                content: Text(state.errorMessage),
              ),
              Positioned(
                top: 415,
                right: 55,
                child: RaisedButton(
                    elevation: 0.0,
                    onPressed: () =>
                        BlocProvider.of<UserBloc>(context).add(FetchGitUsers()),
                    color: Colors.teal,
                    child: Text('Retry')),
              )
            ],
          );
        }

        return Container();
      }),
    );
  }
}
