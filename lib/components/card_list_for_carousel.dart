import 'package:flutter/material.dart';

import '../models/phones.dart';
import '../views/phone_details_view.dart';

class CardListForCarousel {
  List<InkWell> cardList(Results result, BuildContext context) {
    return result.horizontalProducts
        .map(
          (item) => InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PhoneDetailsView()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  result.products[result.horizontalProducts.indexOf(item)]
                      .imageUrl,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    result.products[result.horizontalProducts.indexOf(item)]
                                .dropRatio !=
                            null
                        ? '%${result.products[result.horizontalProducts.indexOf(item)].dropRatio.toString()}'
                        : '%-',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 150,
                        child: Text(
                          result
                                  .horizontalProducts[
                                      result.horizontalProducts.indexOf(item)]
                                  .name ??
                              '',
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontSize: 13, color: Colors.blue.shade800),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          result
                                  .horizontalProducts[
                                      result.horizontalProducts.indexOf(item)]
                                  .price
                                  .toString() ??
                              '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                          '${result.horizontalProducts[result.horizontalProducts.indexOf(item)].countOfPrices} satıcı' ??
                              '',
                          style: const TextStyle(fontSize: 11)),
                      const SizedBox(height: 10),
                      Text(
                          '${result.horizontalProducts[result.horizontalProducts.indexOf(item)].followCount}+ takip' ??
                              '',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
