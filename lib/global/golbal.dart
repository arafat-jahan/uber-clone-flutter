import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currnetUser;


//UserModel? UserModelCurrentInfo.

// current user er database info (name, phone, etc.)
UserModel? userModelCurrentInfo;