import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
void main() {
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
            SignInButton(
              Buttons.Google
              , onPressed: _loggati
            ),
            if(_nomeUtente != null && _email != null)
          Column(
            children: [
               Text('Nome Utente: $_nomeUtente'),
              Text('Email: $_email')
            ]
          ),
          if(_error != null) Text('Errore: $_error')
          ],
        
        ),

        
      ),
    
    );
  }

  Future <void> _loggati() async {
  } 

  Future <void> _sloggati() async {
  }
}
