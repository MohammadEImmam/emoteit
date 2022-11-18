import 'package:flutter/material.dart';
import 'getdata.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emote-It',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Emote-It'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyAppState();

}


class _MyAppState extends State<MyHomePage> {
  late Future<Stats> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchStats();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Stats>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Emortions : ${snapshot.data!.emortionCount} \n"
                    "Insights : ${snapshot.data!.insightCount} \n"
                    "Emorters : ${snapshot.data!.newUserCount} \n"
                    "Relationships : ${snapshot.data!.newRelationshipCount} \n");
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
