import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

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


class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ListenerWidget(),
            DragWidget(),
            DoubleGestureWidget(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home),text: "指针事件",),
            Tab(icon: Icon(Icons.rss_feed),text: "手势",),
            Tab(icon: Icon(Icons.perm_identity),text: "手势冲突",)
          ],
          unselectedLabelColor: Colors.blueGrey,
          labelColor: Colors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}


class ListenerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        child: Container(
          color: Colors.red,
          width: 300,
          height: 300,
        ),
        onPointerDown: (event) => print("down $event"),
        onPointerMove:  (event) => print("move $event"),
        onPointerUp:  (event) => print("up $event"),
      )
    );
  }
}


class DragWidget extends StatefulWidget {
  @override
  _DragState createState() => new _DragState();
}

class _DragState extends State<DragWidget> {
  double _top = 0.0; //距顶部的偏移
  double _left = 0.0;//距左边的偏移

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo"),),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: Container(color: Colors.red,width: 50,height: 50),
              onTap: ()=>print("Tap"),
              onDoubleTap: ()=>print("Double Tap"),
              onLongPress: ()=>print("Long Press"),
              onPanUpdate: (e) {
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
            ),
          )
        ],
      )
    );
  }
}

class DoubleGestureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: RawGestureDetector(
        gestures: {
          MultipleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
              MultipleTapGestureRecognizer>(
                () => MultipleTapGestureRecognizer(),
                (MultipleTapGestureRecognizer instance) {
              instance.onTap = () => print('parent tapped ');
            },
          )
        },
        child: Container(
          color: Colors.pinkAccent,
          child: Center(
            child: GestureDetector(
                onTap: () => print('Child tapped'),
                child: Container(
                  color: Colors.blueAccent,
                  width: 200.0,
                  height: 200.0,
                )),
          ),
        ),
      )
    );
  }

}


class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}