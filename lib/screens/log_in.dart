import 'package:diary_app/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/widgets/log_in_button.dart';
import 'home.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn>
{
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading? Center(child: CircularProgressIndicator(),): Stack(
      fit: StackFit.expand,
      children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/background2.png"), fit: BoxFit.fill)
            )
        ),
        Column(
          children: [
            Expanded(flex: 8, child: Container(),),
            LogInButton(loginHandler),
            Expanded(flex: 1, child: Container())
          ],
        )
      ],
    );
  }

  Future loginHandler() async {
    setState(() {
      isLoading = true;
    });
    String clientId = 'x7O56u2WSO7Ve2XKkKmpUukfwNpolKob';
    String domain = 'selmy96.auth0.com';
    Auth auth = Auth(domain, clientId);
    String tokenId = await auth.signIn();
    print(tokenId);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(tokenId)));
  }
}
