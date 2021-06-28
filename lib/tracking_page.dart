import 'package:flutter/material.dart';

import 'api-methods.dart';
import 'model.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Price'),
      ),
      body: getDataChart(),
    );
  }

  Widget getDataChart() => FutureBuilder<List<Coin>>(
        future: CoinApi.getCurrentData(context),
        builder: (context, snapshot) {
          print('Inside futureB 1st exp');
          final users = snapshot.data;
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return buildChart(users!);
          }
        },
      );

  Widget buildChart(List<Coin> users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemExtent:80,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.white,
            ),
            title: Row(
              children: [Text(user.name), 
              Spacer(), Text('₹ ${user.price}')
              ],
            ),
            subtitle: Text('Rank ${user.rank}'),
          );
        },
      );
}
