import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_demo/src/model/source_model.dart';
import '../controller/api_manager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<NewsModel> _newsModel;

  void initState() {
    _newsModel = APIManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
          centerTitle: true,
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          backgroundColor: Color.fromARGB(255, 220, 223, 220),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return _newsModel = APIManager().getNews();
          },
          child: Container(
            decoration:
                new BoxDecoration(color: Color.fromARGB(255, 220, 223, 220)),
            child: FutureBuilder<NewsModel>(
              future: _newsModel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles.length,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.articles[index];
                        var formattedTime = DateFormat('dd MMM - HH:mm')
                            .format(article.publishedAt);
                        return InkWell(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  child: AspectRatio(
                                    aspectRatio: 3,
                                    child: Image.network(
                                      article.urlToImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(formattedTime),
                                Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => launch(article.url),
                        );
                      });
                } else
                  return Center(
                    //child: CupertinoActivityIndicator(radius: 20),
                    child: CircularProgressIndicator(),
                  );
              },
            ),
          ),
        ));
  }
}
