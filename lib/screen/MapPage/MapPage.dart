import 'package:carrent/model/Company/CompanyModel.dart';
import 'package:carrent/provider/Company_Provider.dart';
import 'package:carrent/screen/MapPage/Details/CompanyCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart' as img;

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  late GoogleMapController mapController;

  final LatLng _initialPosition = const LatLng(33.888630, 35.495480);
  Set<Marker> _markers = {};
  Company? _selectedCompany; // To store the selected company
  bool _isDetailsVisible =
      false; // Control the visibility of the company details

  @override
  void initState() {
    super.initState();
  }

  void _loadMarkers(List<Company> allCompanies) async {
    for (var company in allCompanies) {
      BitmapDescriptor markerIcon;
      try {
        markerIcon = await _getMarkerIcon(company.imageCompany![0].image.url);
      } catch (e) {
        print('Error loading marker image for ${company.companyName}: $e');
        continue; // Skip the marker if the image loading fails
      }

      setState(() {
        _markers.add(Marker(
          markerId: MarkerId(company.companyName),
          position: LatLng(company.latitude, company.longitude),
          icon: markerIcon,
          infoWindow: InfoWindow(
            title: '${company.companyName} - ${company.carCount} cars',
            snippet: 'More details',
            onTap: () {
              _onMarkerTapped(company); // Handle marker tap
            },
          ),
        ));
      });
    }
  }

  // Method to load marker image from network and convert it to BitmapDescriptor
  Future<BitmapDescriptor> _getMarkerIcon(String imageUrl) async {
    try {
      // Fetch the image from the network
      final file = await DefaultCacheManager().getSingleFile(imageUrl);
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(Uint8List.fromList(bytes));

      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // Resize the image (optional)
      final resizedImage = img.copyResize(image, width: 100, height: 100);

      // Convert the resized image to bytes
      final resizedBytes = Uint8List.fromList(img.encodePng(resizedImage));

      return BitmapDescriptor.fromBytes(resizedBytes);
    } catch (e) {
      return BitmapDescriptor
          .defaultMarker; // Fallback to default marker if the image fails to load
    }
  }

  // Method to handle tap on marker and show company details
  void _onMarkerTapped(Company company) {
    setState(() {
      _selectedCompany = company;
      _isDetailsVisible = true; // Show company details
    });
  }

  void _hideCompanyDetails() {
    setState(() {
      _isDetailsVisible = false; // Hide company details
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<CompanyProvider>(
            builder: (context, companyProvider, child) {
              if (companyProvider.allCompanies.isEmpty) {
                companyProvider.getAllCompany();
              }

              if (companyProvider.allCompanies.isNotEmpty && _markers.isEmpty) {
                _loadMarkers(companyProvider.allCompanies);
              }

              return GoogleMap(
                onMapCreated: _onMapCreated,
                mapToolbarEnabled: false, // Disable map toolbar
                zoomControlsEnabled: false, // Disable zoom controls
                myLocationButtonEnabled: false, // Disable the location button

                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 13.0,
                ),
                markers: _markers, // Pass the markers here
              );
            },
          ),
          if (_isDetailsVisible && _selectedCompany != null)
            Positioned(
              bottom: 15.w,
              left: 20.w,
              right: 20.w,
              child: GestureDetector(
                onTap: _hideCompanyDetails, // Hide details on tap outside
                child: CompanyCard(selectedCompany: _selectedCompany),
              ),
            ),
        ],
      ),
    );
  }
}
