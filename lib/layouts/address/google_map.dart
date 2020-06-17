import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

import '../../utils/logger.dart';

class HGoogleMap extends StatefulWidget {
  const HGoogleMap({
    this.currentLat,
    this.currentLong,
    Key key,
  }) : super(key: key);
  
  final double currentLat;
  final double currentLong;

  @override
  _HGoogleMapState createState() => _HGoogleMapState();
}

class _HGoogleMapState extends State<HGoogleMap> {
  final GlobalKey<GoogleMapStateBase> _googleMapKey =
      GlobalKey<GoogleMapStateBase>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      key: _googleMapKey,
      initialPosition: GeoCoord(widget.currentLat, widget.currentLong),
      markers: {
        Marker(
          GeoCoord(widget.currentLat, widget.currentLong),
        )
      },
      initialZoom: 18,
      onTap: (coord) {
        GoogleMap.of(_googleMapKey).clearMarkers();
        GoogleMap.of(_googleMapKey).addMarker(
          Marker(
            GeoCoord(coord.latitude, coord.longitude),
            onTap: (value) {
              logger.i('Marker tap: $value');
            },
          ),
        );
      },
    );
  }
}
