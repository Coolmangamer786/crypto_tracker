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
        title: Text('Crypto Tracker'),
      ),
      body: getDataChart(),
    );
  }

  Widget getDataChart() => FutureBuilder<List<Coin>>(
        future: CoinApi.getCurrentData(context),
        builder: (context, snapshot) {
          // print('Inside futureB 1st exp');
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

  Widget buildChart(List<Coin> users) => ListView.separated(
        separatorBuilder: ((context, index) => Divider()),
        padding: EdgeInsets.all(8),
        physics: BouncingScrollPhysics(),
        // itemExtent: 80,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          final user = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              backgroundColor: Colors.white,
            ),
            title: Text(
              '${user.name} (${user.sortform.toUpperCase()})',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            //  Row(
            //   children: [Text(user.name),
            //   Spacer(), Text('₹ ${user.price}')
            //   ],
            // ),
            // subtitle: Text('Rank ${user.rank}'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '₹ ${user.price}',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                setPercentage(user.change)
              ],
            ),
          );
        },
      );

  Widget setPercentage(double per) {
    if (per < 0) {
      per = per + per * -2;
      return Text(
        "▼ ${per.toStringAsFixed(2)} %",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    }
    return Text(
      "▲ ${per.toStringAsFixed(2)} %",
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    );
  }
}
