import 'package:flutter/material.dart';

import '../models/phones.dart';
import '../views/phone_details_view.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    Key key,
    @required this.result,
  }) : super(key: key);

  final Results result;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: result.products.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PhoneDetailsView()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Text(
                              result.products[index].dropRatio != null
                                  ? '%${result.products[index].dropRatio.toString()}'
                                  : '%-',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Image.network(
                              result.products[index].imageUrl,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      result.products[index].name ?? '',
                      style:
                          TextStyle(fontSize: 12, color: Colors.blue.shade800),
                      softWrap: false,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${result.products[index].price} TL',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 3),
                    Text(
                        result.products[index].countOfPrices != null
                            ? '${result.products[index].countOfPrices} satıcı'
                            : '0 satıcı',
                        style: const TextStyle(fontSize: 11)),
                    const SizedBox(height: 10),
                    Text(
                        result.products[index].followCount != null
                            ? '${result.products[index].followCount}+ takip'
                            : '0 takip',
                        style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
