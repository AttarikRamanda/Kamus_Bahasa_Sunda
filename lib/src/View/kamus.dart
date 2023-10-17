import 'package:flutter/material.dart';
import 'package:sundaku/src/widget/navbar.dart';
import '../components/Datak.dart';

class Kamus extends StatefulWidget {
  @override
  _KamusState createState() => _KamusState();
}

class _KamusState extends State<Kamus> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, List<String>>> dataList = Datak.data;
  List<Map<String, List<String>>> filteredDataList = [];

  @override
  void initState() {
    super.initState();
    filteredDataList = dataList;
  }

  void filterList(String searchQuery) {
    if (searchQuery.isNotEmpty) {
      setState(() {
        filteredDataList = dataList.where((data) {
          return data.values.any((values) {
            return values.any((value) =>
                value.toLowerCase().contains(searchQuery.toLowerCase()));
          });
        }).toList();
      });
    } else {
      setState(() {
        filteredDataList = dataList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navbar(),
      appBar: AppBar(
        title: Text('Kamus'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterList(value);
              },
              decoration: InputDecoration(
                hintText: 'Masukkan kata kunci',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
                filled: true,
                fillColor: Colors.grey[200],
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20.0,
                  dataRowHeight: 40.0,
                  headingRowHeight: 60.0,
                  columns: [
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Basa Loma (Biasa)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Basa Lemes keur Sorangan',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Basa Lemes ker Batur',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Bahasa Indonesia',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    filteredDataList.length,
                    (index) {
                      String basaLoma =
                          filteredDataList[index]['basaLoma']!.first;
                      String basaLemesSorangan =
                          filteredDataList[index]['basaLemesSorangan']!.first;
                      String basaLemesBatur =
                          filteredDataList[index]['basaLemesBatur']!.first;
                      String bahasaIndonesia =
                          filteredDataList[index]['bahasaIndonesia']!.first;
                      return DataRow(
                        cells: [
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                basaLoma,
                                style: TextStyle(fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                basaLemesSorangan,
                                style: TextStyle(fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                basaLemesBatur,
                                style: TextStyle(fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                bahasaIndonesia,
                                style: TextStyle(fontSize: 14.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
