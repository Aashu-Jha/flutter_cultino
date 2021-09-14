import 'package:flutter/material.dart';
import 'package:flutter_cultino/models/mandi_model.dart';
import 'package:flutter_cultino/viewmodels/mandi_viewmodel.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('Other Mandi List'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: Provider.of<MandiViewModel>(context, listen: false)
              .fetchAndSetProducts(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Consumer<MandiViewModel>(
                      builder: (ctx, data, _) => ListView.separated(
                          itemBuilder: (context, index) => MandiCard(
                                entry: data.list[index],
                              ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: data.list.length),
                    ),
        ),
      ),
    );
  }
}

class MandiCard extends StatelessWidget {
  final OtherMandi entry;
  const MandiCard(
      {Key? key,
      required this.entry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _header(context),
          ListTile(
            title: Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.hindiName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(entry.lastDate),
                  ],
                )),
            subtitle: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Text(entry.state + entry.district, maxLines: 1)),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext ctx) {
    if (entry.image != null) {
      return Stack(
        children: [
          CoverImageDecoration(
              url: entry.image,
              width: null,
              height: 120.0,
          ),
        ]
      );
    } else {
      return Container(
        width: double.infinity,
        height: 120.0,
        color: Colors.green,
      );
    }
  }
}


class CoverImageDecoration extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final double borderRadius;

  CoverImageDecoration(
      {this.url,
      this.height,
      this.width = 0,
      this.borderRadius = 0,
      });

  @override
  Widget build(BuildContext ctx) {
    final imgUrl = url == null ? "" : url;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.grey,
        image: DecorationImage(
            image: NetworkImage(imgUrl!), fit: BoxFit.cover),
      ),
    );
  }
}



