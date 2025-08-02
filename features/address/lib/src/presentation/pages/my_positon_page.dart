import 'package:address/src/utils/routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ui/ui.dart';
import '../viewmodels/my_position_viewmodel.dart';

class MyPositonPage extends StatefulWidget {
  final double lat;
  final double lng;
  const MyPositonPage({required this.lat, required this.lng, super.key});

  @override
  State<MyPositonPage> createState() => _MyPositonPageState();
}

class _MyPositonPageState extends State<MyPositonPage> {
  late MyPositionViewmodel _viewModel;

  void _onConfirm() {
    context.pushNamed(
      Routes.manuallyNamed,
      queryParameters: {
        'lat': _viewModel.latLng.latitude.toString(),
        'lng': _viewModel.latLng.longitude.toString(),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // _viewModel = MyPositionViewmodel(lat: -21.790350, lng: -46.537315);
    _viewModel = MyPositionViewmodel(lat: widget.lat, lng: widget.lng);
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewModel.updatePoint(context));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text('SELECIONE A SUA POSIÇÃO'),
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          return Stack(
            children: [
              FlutterMap(
                mapController: _viewModel.mapController,
                options: MapOptions(
                  onPositionChanged: (camera, hasGesture) => _viewModel.updatePoint(context),
                  initialCenter: _viewModel.latLng,
                  initialZoom: 18,
                  minZoom: 18,
                ),
                children: [
                  TileLayer(
                    urlTemplate: Env.mapboxlight,
                  ),
                  MarkerLayer(markers: [
                    Marker(
                      point: _viewModel.latLng,
                      height: 45,
                      width: 45,
                      child: Stack(
                        children: [
                          PaipIcon(
                            PaipIcons.mapPointBold,
                            size: 45,
                            color: context.artColorScheme.primary,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.artColorScheme.primary.withOpacity(0.2),
                            ),
                          )
                              .animate(
                                onComplete: (controller) => controller.repeat(),
                              )
                              .scaleXY(
                                begin: 0.5,
                                end: 2.0,
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOut,
                              )
                              .fadeOut(
                                duration: const Duration(milliseconds: 1500),
                                curve: Curves.easeOut,
                              ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(16) + EdgeInsets.only(bottom: 12),
                  child: ArtButton(
                    enabled: _viewModel.isEnabledButton,
                    onPressed: () => _onConfirm(),
                    child: Text('Confirmar'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
