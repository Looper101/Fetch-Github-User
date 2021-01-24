import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_user/model/user.dart';

class ProfilePage extends StatelessWidget {
  static final id = 'routeid';
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(children: [
            Container(
              height: 600,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: user.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 15,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                  child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                height: 120,
                width: 500,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.black],
                  ),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        user.name.toUpperCase(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Positioned(
            //   left: 0,
            //   bottom: 0,
            //   right: 0,
            //   child: Container(
            //     height: 370,
            //     width: 400,
            //     decoration: BoxDecoration(
            //       color: Colors.black,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(30),
            //         topRight: Radius.circular(30),
            //       ),
            //     ),
            //     child: UserDetailSection(user),
            //   ),
            // ),
          ]),
        ),
      ),
    );
  }
}

Widget UserDetailSection(User user) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
    child: Column(
      children: [
        Row(
          children: [
            Text(user.name.toUpperCase()),
            Text(user.id.toString()),
          ],
        )
      ],
    ),
  );
}
