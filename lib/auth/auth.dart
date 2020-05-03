import 'package:flutter_auth0/flutter_auth0.dart';

class Auth
{
  Auth0 _auth0;
  Auth(String domain, String clientId)
  {
    _auth0 = Auth0(baseUrl: 'https://$domain/', clientId: clientId);
  }

  Future<String> signIn() async
  {
    
    try
    {
      var response = await _auth0.webAuth.authorize(
        {
          'domain':'selmy96.auth0.com',
          'scope': 'openid'
        });
      
      return response['id_token'];
    }
    catch (e) 
    {
      print('Error: $e');
    }
    return "";
  }
}