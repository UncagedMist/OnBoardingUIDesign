import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboarding_flutter/ui/home.dart';
import 'package:onboarding_flutter/widgets/swipe_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SwiperController controller = SwiperController();
  int pageCount = 5;
  int currentIndex = 0;

  List<String> pageTitle = [
    "Iron Man \n Tony Stark",
    "Captain America \n Steve Rogers",
    "Black Widow \n Natasha Romanoff",
    "Captain Marvel \n Carol Danvers",
    "Spider Man \n Peter Parker"
  ];

  String background = "assets/background.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(background, fit: BoxFit.contain),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Swiper(
                  index: currentIndex,
                  controller: controller,
                  itemCount: pageCount,
                  onIndexChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  loop: false,
                  itemBuilder: (context, index) {
                    return createPage(
                        title: pageTitle[index],
                        icon: "assets/${index + 1}.jpg");
                  },
                  pagination: SwiperPagination(
                    builder: new CustomPaginationBuilder(
                        activeSize: Size(10.0, 20.0),
                        size: Size(10.0, 15.0),
                        color: Colors.grey.shade600),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              createButtons(),
            ],
          )
        ],
      ),
    );
  }

  Widget createButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            textColor: Colors.grey.shade700,
            child: Text("Skip"),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomePage()));
            },
          ),
          IconButton(
            icon: Icon(
              currentIndex < pageCount - 1
                  ? FontAwesomeIcons.arrowCircleRight
                  : FontAwesomeIcons.checkCircle,
              size: 40,
            ),
            onPressed: () async {
              if (currentIndex < pageCount - 1)
                controller.next();
              else {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomePage()));
              }
            },
          )
        ],
      ),
    );
  }

  Widget createPage({String title, String icon}) {
    TextStyle titleStyle =
        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(50.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
              image: AssetImage(icon),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black38, BlendMode.multiply)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(5.0, 5.0),
                color: Colors.black26)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle.copyWith(color: Colors.white),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
