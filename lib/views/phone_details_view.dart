import 'package:flutter/material.dart';

import '../models/phone_details.dart';
import '../services/web_service.dart';

class PhoneDetailsView extends StatefulWidget {
  const PhoneDetailsView({Key key}) : super(key: key);

  @override
  State<PhoneDetailsView> createState() => _PhoneDetailsViewState();
}

class _PhoneDetailsViewState extends State<PhoneDetailsView> {
  Future<PhoneDetails> futurePhoneDetails;
  //PhoneDetails phoneDetails;

  void getDetails() async {
    futurePhoneDetails = WebService().fetchPhoneDetails();
    //phoneDetails = await futurePhoneDetails;
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Details'),
      ),
      body: Center(
        child: FutureBuilder<PhoneDetails>(
          future: futurePhoneDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data.result.mkName,
                              style: TextStyle(color: Colors.blue.shade800)),
                          Row(
                            children: [
                              Text(snapshot.data.result.rating.toString()),
                              const Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        snapshot.data.result.productName,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        snapshot.data.result.badge,
                        style:
                            TextStyle(backgroundColor: Colors.yellow.shade100),
                      ),
                      Padding(
                        padding: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? const EdgeInsets.fromLTRB(120, 20, 120, 20)
                            : const EdgeInsets.fromLTRB(250, 20, 250, 20),
                        child: Image.network(
                          snapshot.data.result.imageUrl,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const Divider(),
                      const Center(child: Text('Kapasite seçenekleri')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              snapshot.data.result.storageOptions[0],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              snapshot.data.result.storageOptions[1],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              snapshot.data.result.storageOptions[2],
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Center(
                          child: Text(
                              '${snapshot.data.result.countOfPrices} satıcı içinde kargo dahil en ucuz fiyat seçeneği',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      const SizedBox(height: 10),
                      Center(
                          child: Text('${snapshot.data.result.price} TL',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20))),
                      const SizedBox(height: 5),
                      if (snapshot.data.result.freeShipping)
                        const Center(
                            child: Text(
                          'Ücretsiz kargo',
                          style: TextStyle(color: Colors.green),
                        )),
                      const SizedBox(height: 5),
                      Center(
                          child: Text(
                              'Son Güncelleme: ${snapshot.data.result.lastUpdate}')),
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                        const SizedBox(height: 300),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
