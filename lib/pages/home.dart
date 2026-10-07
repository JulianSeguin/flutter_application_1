import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/X.webp', height: 30),
          backgroundColor: Colors.black,
          centerTitle: true,
          leading: const Center(
            child: CircleAvatar(
              radius: 18,
              foregroundImage: NetworkImage(
                'https://avatar.shifaul.dev/random',
              ),
            ),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            dividerColor: Colors.grey,
            dividerHeight: 0.5,
            tabs: [
              Tab(text: 'Pour vous'),
              Tab(text: 'Abonnements'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SizedBox.shrink(),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
