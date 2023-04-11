import 'package:nado_client_mvp/app/data/model/userfaq.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';

extension FAQProviderEx on NadoProvider {
  Future<void> postUserFAQ({required UserFAQ userFeedBack}) async {
    await post('/api/v1/feedback/save', userFeedBack.toJson());
  }
}
