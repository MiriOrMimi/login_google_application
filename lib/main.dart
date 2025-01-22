import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _nomeUtente;
  String? _email;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            SignInButton(Buttons.Google, onPressed: _loggati),
            if (_nomeUtente != null && _email != null)
              Column(children: [
                Text('Nome Utente: $_nomeUtente'),
                Text('Email: $_email')
              ]),
            if (_error != null) Text('Errore: $_error'),
            ElevatedButton(onPressed: _sloggati, child: const Text('logout'))
          ],
        ),
      ),
    );
  }

  Future<void> _loggati() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.accessToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        setState(() {
          _nomeUtente = user.displayName;
          _email = user.email;
        });
      }
    } catch (e) {
      setState() {
        _error = 'Errore durante il login con google $e';
      }
    }
  }

  Future<void> _sloggati() async {
    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      setState(() {
        _error = 'Errore durante il logout con Google: $e';
      });
    }
  }
}
