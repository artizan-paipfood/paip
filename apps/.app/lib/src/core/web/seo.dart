import 'package:core_flutter/core_flutter.dart';
import 'package:meta_seo/meta_seo.dart';

void loadSeo({String? ogTitle, String? description, List<String>? keywords}) {
  if (!isWeb) return;
  final meta = MetaSEO();
  if (ogTitle != null) meta.ogTitle(ogTitle: ogTitle);
  if (description != null) meta.description(description: description);
  if (keywords != null) meta.keywords(keywords: keywords.join(', '));
}
