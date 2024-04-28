import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/consumtion_provider.dart';
import '../models/consumepation.dart';


class ConsumptionPage extends StatefulWidget {
  @override
  _ConsumptionPageState createState() => _ConsumptionPageState();
}

class _ConsumptionPageState extends State<ConsumptionPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConsumptionProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Consumption Statistics'),
          backgroundColor: Color(0xFF005573),
        ),
        body: Consumer<ConsumptionProvider>(
          builder: (context, consumptionProvider, child) {
            return FutureBuilder(
              future: Future.wait([
                consumptionProvider.getTopThreeSavedConsumers(),
                consumptionProvider.getTotalConsumptionSaved(),
              ]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<ConsumptionModel> topThreeConsumers = snapshot.data![0] as List<ConsumptionModel>;
                  int totalConsumptionSaved = snapshot.data![1] as int;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Top 3 Saved Consumers',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF005573),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: topThreeConsumers.length,
                          itemBuilder: (context, index) {
                            ConsumptionModel consumer = topThreeConsumers[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Color(0xFF005573),
                                        child: Text(
                                          '${consumer.firstName[0]}${consumer.lastName[0]}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${consumer.firstName} ${consumer.lastName}',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4.0),
                                            Text(
                                              'Consumption Expected: ${consumer.consumptionExpected}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Consumption Saved',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005573),
                              ),
                            ),
                            Text(
                              '$totalConsumptionSaved',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF005573),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
