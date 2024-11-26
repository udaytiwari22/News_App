import 'package:flutter/material.dart';
import 'package:fresh_news/Data/news.dart';
import 'package:fresh_news/models/blogs.dart';

class CategoryNews extends StatefulWidget {
  final String? category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<blogs> articles = [];
  bool loading = true;
  @override
  void initState() {
    getCategoryNews();
    super.initState();
  }

  getCategoryNews() async {
    CategoryNewsClass news = CategoryNewsClass();
    await news.getnews(widget.category!);
    articles = news.blog;
    setState(
      () {
        loading = false;
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fresh ${widget.category}',
              style: const TextStyle(color: Colors.black),
            ),
            Text(
              ' News',
              style: TextStyle(color: Colors.pink),
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: loading
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return BlockTile(
                              imageurl: articles[index].urltoimage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          })),
                ),
        ),
      ),
    );
  }
}

class BlockTile extends StatelessWidget {
  final String? imageurl, title, desc, url;
  BlockTile(
      {@required this.url,
      @required this.imageurl,
      @required this.title,
      @required this.desc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imageurl!)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                desc!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
