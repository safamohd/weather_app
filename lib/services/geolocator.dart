import 'package:geolocator/geolocator.dart';

 late double latitude ;
  late double longitude ;

  Future<Position> getLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission() ;
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permissions are denied ');
      }

    }
    
    if(permission == LocationPermission.deniedForever){
      
      return Future.error('Location permission is permanently denied , we can not request permission');
    }

    return await Geolocator.getCurrentPosition();
    }


