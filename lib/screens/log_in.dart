import 'package:diary_app/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/widgets/log_in_button.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    String clientId = 'x7O56u2WSO7Ve2XKkKmpUukfwNpolKob';
    String domain = 'selmy96.auth0.com';
    Auth auth = Auth(domain, clientId);
    String tokenid = await auth.signIn();
  }
}
