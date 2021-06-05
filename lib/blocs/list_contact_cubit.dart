import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc_mockapi/blocs/list_contact_state.dart';
import 'package:pattern_bloc_mockapi/model/contact_model.dart';
import 'package:pattern_bloc_mockapi/services/http_service.dart';


class ListContactCubit extends Cubit<ListContactState> {
  ListContactCubit() : super(ListContactInit());

  Future<void> apiListContact() async {
    emit(ListContactLoading());
    String response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      emit(ListContactLoaded(contacts: Network.parsePostList(response)));
    } else {
      emit(ListContactError(error: "Couldn't fetch contacts"));
    }
  }

  Future<void> apiContactDelete(Contact contact) async {
    emit(ListContactLoading());
    String response = await Network.DEL(
        Network.API_DELETE + contact.id, Network.paramsEmpty());
    if (response != null) {
      apiListContact();
    } else {
      emit(ListContactError(error: "Couldn't delete contact"));
    }
  }

}