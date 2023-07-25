import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../components/card_list_for_carousel.dart';
import '../components/custom_grid_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products AA')),
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
                      items: CardListForCarousel().cardList(result, context),
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
                    children: CardListForCarousel()
                        .cardList(result, context)
                        .asMap()
                        .entries
                        .map((entry) {
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
              flex: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 3
                  : 2,
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
                child: Container(
                  color: Colors.blueGrey.shade50,
                  child: CustomGridView(result: result),
                ),
              ),
            ),
          if (isSecondLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
