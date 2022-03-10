import 'package:flutter/material.dart';
import 'package:home_info_panel/models/currency_model.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;
import 'package:windows1251/windows1251.dart';

Future<List<Currency>> getCurrencyFromXML() async {
  final url = Uri.parse('http://www.cbr.ru/scripts/XML_daily.asp');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final document = XmlDocument.parse(windows1251.decode(response.bodyBytes));
    final elements = document.findAllElements('Valute');
    return elements.map((element) {
      return Currency(
          int.parse(element.findElements('NumCode').first.text),
          element.findElements('CharCode').first.text,
          int.parse(element.findElements('Nominal').first.text),
          element.findElements('Name').first.text,
          element.findElements('Value').first.text);
    }).toList();
  } else {
    throw Exception('Failed to load currency');
  }
}

class CurrencyViewer extends StatefulWidget {
  const CurrencyViewer({Key? key}) : super(key: key);

  @override
  State<CurrencyViewer> createState() => _CurrencyViewerState();
}

class _CurrencyViewerState extends State<CurrencyViewer> {
  late Future<List<Currency>> futureCurrency;

  ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
    futureCurrency = getCurrencyFromXML();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Currency>>(
      future: futureCurrency,
      builder: (context, snapshot) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              curve: Curves.linear,
              duration: const Duration(seconds: 120),
            );
          }
        });
        if (snapshot.hasData) {
          return SizedBox(
            height: 50,
            child: ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                // physics: ScrollPhysics().,
                separatorBuilder: (context, index) => const VerticalDivider(
                      thickness: 5,
                      color: Colors.yellow,
                    ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    // color: Colors.white,
                    // height: 100,
                    width: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${snapshot.data!.elementAt(index).nominal}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              snapshot.data!.elementAt(index).charCode,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const Text(' = '),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data!.elementAt(index).value} \u20bd',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                snapshot.data!.elementAt(index).name,
                                //overflow: TextOverflow.ellipsis,
                                //softWrap: true,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic, fontSize: 12),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        } else {
          if (snapshot.hasError) {
            return Text('${snapshot.hasError}');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
            ),
          );
        }
      },
    );
  }
}
