import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:fresh_news/Data/news.dart';
import 'package:fresh_news/Data/data.dart';
import 'package:fresh_news/Pages/artice.dart';
import 'package:fresh_news/Pages/category.dart';
import 'package:fresh_news/models/blogs.dart';
import 'package:fresh_news/models/categorymodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

 @override
 State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<categorymodel> categories =[];
  List<blogs> articles = [];
  bool loading =true;
  News news =News();
  @override
   void initState(){
    super.initState();
    categories=getcategories();
    getNews();
  }

  getNews() async{
    articles = await news.getnews();
    print(articles);
    setState(() {
      loading =false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.pink,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Fresh',
              style: TextStyle(
                color: Colors.black
              ),
            ),
            Text(' News',
              style: TextStyle(
                  color: Colors.pink
              ),
            )
          ],
        ),
      ),
      body: loading ? const Center(child: CircularProgressIndicator(),)
      :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(

            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                 
                  
                  children: categories.map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Tile(
                          imageurl:e.imageurl ,
                          name: e.name,
                        ),
                      )).toList(),
                ),
              ),
              
              Divider(
                thickness: 2,
                color: Colors.pink.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Container(

                  child:ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: articles.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                      return BlockTile(
                        imageurl:articles[index].urltoimage ,
                        title:articles[index].title ,
                        desc: articles[index].description,
                        url:articles[index].url,
                      );
                      }
                  )
                ),
              )


            ],
          ),
        ),
      )
    );
  }
}
class Tile extends StatelessWidget {
  final String? imageurl;
  final String? name;
  const Tile({super.key, this.imageurl,this.name,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(
          category: name.toString().toLowerCase(),
        )));
      },
      child: Container(
       
      margin: EdgeInsets.only(right: 13.0),
        child:Column(
        
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
                child:CachedNetworkImage(imageUrl: imageurl!,width:120.0,height: 80.0,fit: BoxFit.cover,)),
             const SizedBox(height: 4,),
            Container(
                alignment: Alignment.center,
                child:Text(name!,style:const TextStyle(
                color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  )
                )
            ),

          ],
        )
      ),
    );
  }
}
class BlockTile extends StatelessWidget {
  final String? imageurl,title,desc,url;
  BlockTile(
      {@required this.url,@required this.imageurl,@required this.title,@required this.desc}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(
            builder: (context)=>ArticleView(
            imageurl:url,
            )
        ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
                child: Image.network(imageurl!)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title!, style: TextStyle(
                fontSize: 20.0,
                fontWeight:FontWeight.w800,
                fontStyle:FontStyle.italic,

              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text

                (desc!,style: TextStyle(
                color: Colors.black54,
                fontSize: 17.0,
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}