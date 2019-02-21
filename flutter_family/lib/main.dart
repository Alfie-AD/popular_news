import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(FlutterFamily());

class FlutterFamily extends StatelessWidget {
  build(context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget{
  build(context) {
    return CupertinoTabView(
      builder: (context){
        return  FlutterMap(
          options:  MapOptions(
            center:  LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
//            TileLayerOptions(
//              offlineMode: true,
//              urlTemplate: "assets/offlineMap/{z}/{x}/{y}.png",
//            ),
            new TileLayerOptions(
              urlTemplate: "https://api.tiles.mapbox.com/v4/"
                  "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
              additionalOptions: {
                'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
                'id': 'mapbox.streets',
              },
            ),
            new MarkerLayerOptions(
              markers: [
                new Marker(
                  width: 80.0,
                  height: 80.0,
                  point: new LatLng(51.5, -0.09),
                  builder: (ctx) =>
                  new Container(
                    child: new FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}

