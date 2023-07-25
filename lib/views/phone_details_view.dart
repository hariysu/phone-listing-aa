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
              return Text(snapshot.data.result.productName);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
