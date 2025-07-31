// ignore_for_file: cascade_invocations

import 'package:api/apis/adress/cep_awesome_api.dart';
import 'package:api/apis/adress/google_places_api.dart';
import 'package:api/apis/adress/postcodes_api.dart';
import 'package:api/apis/adress/radar_api.dart';
import 'package:auto_injector/auto_injector.dart';
import 'package:api/repositories/address/search_address/search_address_repository.dart';
import 'package:core/core.dart';
import 'package:api/constants/base_url.dart';
import 'package:api/services/process_env.dart';
import 'package:api/repositories/address/delivery_repository.dart';
import 'package:api/apis/adress/address_user_establishment_api.dart';
import 'package:api/repositories/stripe/i_stripe_repository.dart';
import 'package:api/repositories/stripe/stripe_repository.dart';
import 'package:api/services/authenticator.dart';
import 'package:api/usecases/distance_delivery_usecase.dart';
import 'package:api/usecases/stripe_charge_usecase.dart';
import 'package:api/usecases/stripe_split_usecase.dart';
import 'package:api/usecases/update_queus_usecase.dart';
import 'package:hipay/hipay.dart';

final injector = AutoInjector();

class BackInjector {
  BackInjector._();
  static void initialize() {
    injector.addSingleton<Authenticator>(Authenticator.new);
    injector.add<IChargesRepository>(() => ChargesRepository(client: injector.get(key: 'supabaseClient')));
    injector.add<ChargeSplitApi>(() => ChargeSplitApi(client: injector.get(key: 'supabaseClient')));
    injector.add<IClient>(ClientDio.new);
    injector.add<IClient>(() => ClientDio(baseOptions: DioBaseOptions.supabase), key: 'supabaseClient');
    injector.add<IStripeRepository>(() => StripeRepository(client: ClientDio(baseOptions: DioBaseOptions.stripe)));
    injector.add<StripeChargeUsecase>(StripeChargeUsecase.new);
    injector.add<StripeSplitUsecase>(() => StripeSplitUsecase(repository: injector.get(), chargeSplitApi: injector.get(), chargesApi: injector.get()));
    injector.add<UpdateQueusApi>(() => UpdateQueusApi(client: injector.get(key: 'supabaseClient')));
    injector.add<UpdateQueusUsecase>(() => UpdateQueusUsecase(api: injector.get()));
    injector.add<ViewsApi>(() => ViewsApi(client: injector.get(key: 'supabaseClient')));
    injector.add<Hipay>(() => Hipay(apiKey: ProcessEnv.hipayApiKey, enableLogs: true));
    // Address api
    injector.add<PostCodesApi>(() => PostCodesApi(client: injector.get()));
    injector.add<CepAwesomeApi>(() => CepAwesomeApi(client: injector.get()));
    injector.add<GooglePlacesApi>(() => GooglePlacesApi(client: injector.get()));
    injector.add<RadarApi>(() => RadarApi(client: injector.get()));
    injector.add<ISearchAddressRepository>(() => GbSearchAddressRepository(postCodesApi: injector.get(), googlePlacesApi: injector.get()), key: 'gb-address-api');
    injector.add<ISearchAddressRepository>(() => BrSearchAddressRepository(cepAwesomeApi: injector.get(), radarApi: injector.get()), key: 'br-address-api');
    injector.add<DistanceDeliveryUsecase>(DistanceDeliveryUsecase.new);
    injector.add<IDeliveryRepository>(AddressRepository.new);
    injector.add<IAddressUserEstablishmentApi>(() => AddressUserEstablishmentApi(client: injector.get(key: 'supabaseClient')));
    injector.commit();
  }
}
