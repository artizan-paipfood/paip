import 'package:address/i18n/gen/strings.g.dart';
import 'package:address/src/data/events/route_events.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ui/ui.dart';
import '../viewmodels/my_position_viewmodel.dart';

void showMyPositionDialog(BuildContext context, {required double lat, required double lng}) {
  showDialog(
    context: context,
    builder: (context) => MyPositonPage(lat: lat, lng: lng),
  );
}

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
    ModularEvent.fire(GoManuallyEvent(
      lat: _viewModel.latLng.latitude,
      lng: _viewModel.latLng.longitude,
    ));
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
    return _body();
  }

  Widget _body() {
    return Scaffold(
      appBar: PaipAppBar(
        title: Text(t.selecione_sua_posicao.toUpperCase()),
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
                    urlTemplate: AppConstants.mapLightUrl,
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
                  padding: PSize.spacer.paddingHorizontal + PSize.spacer.paddingBottom,
                  child: ArtButton(
                    enabled: _viewModel.isEnabledButton,
                    onPressed: () => _onConfirm(),
                    child: Text(t.confirmar_posicao),
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
