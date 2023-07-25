import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:phone_listing_aa/views/phone_details_view.dart';

import '../models/phones.dart';
import '../services/web_service.dart';

class PhonesView extends StatefulWidget {
  const PhonesView({Key key}) : super(key: key);

  @override
  State<PhonesView> createState() => _PhonesViewState();
}

class _PhonesViewState extends State<PhonesView> {
  Future<Phones> futurePhones;
  Phones phones;
  Results result;
  bool isFirstLoading = true;
  bool isSecondLoading = true;

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
    getPhones();
  }

  void getPhones() async {
    futurePhones = WebService().fetchPhones();
    phones = await futurePhones;

    result = phones.results;

    setState(() {
      isSecondLoading = false;
      isFirstLoading = false;
    });
  }

  void getNextPhones() async {
    setState(() {
      isSecondLoading = true;
    });

    futurePhones = WebService().fetchPhones(url: phones.results.nextUrl);
    phones = await futurePhones;

    result.products.addAll(phones.results.products);

    setState(() {
      isSecondLoading = false;
    });
  }

  List<InkWell> cardList() {
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
                          style: const TextStyle(fontSize: 12),
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
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          '${result.horizontalProducts[result.horizontalProducts.indexOf(item)].countOfPrices} satıcı' ??
                              '',
                          style: const TextStyle(fontSize: 11)),
                      const SizedBox(height: 10),
                      Text(
                          '${result.horizontalProducts[result.horizontalProducts.indexOf(item)].followCount}+ takip' ??
                              '',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isFirstLoading)
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    //flex: 2,
                    child: CarouselSlider(
                      items: cardList(),
                      carouselController: _controller,
                      //Slider Container properties
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cardList().asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          if (!isFirstLoading)
            Expanded(
              flex: 3,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isSecondLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      phones.results.nextUrl.isNotEmpty) {
                    getNextPhones();
                  }
                  return true;
                },
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          result.products[index].dropRatio !=
                                                  null
                                              ? '%${result.products[index].dropRatio.toString()}'
                                              : '%-',
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                  style: const TextStyle(fontSize: 12),
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${result.products[index].price} TL',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
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
                    }),
              ),
            ),
          if (isSecondLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
