import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:skp_port/di/injection.config.dart';

//* Get instance of GetIt.
final locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configure() async => $initGetIt(locator);

@module
abstract class RegisterModule {
  //* Register FirebaseAuth module
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  //* Register Firestore module
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
