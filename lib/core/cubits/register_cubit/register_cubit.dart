import 'package:bloc/bloc.dart';
import 'package:easy_shop/core/models/register_model.dart';
import 'package:easy_shop/public/shared/remote/logic/dio_helper.dart';
import 'package:easy_shop/public/shared/remote/logic/endPoints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;

  void register({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: Endpoints.register, data: {
      "email": email,
      "phone": password,
      "name": name,
      "confirmPassword": confirmPassword,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      print('${RegisterModel}');
      emit(RegisterSuccessState());
    }).catchError((onError) {
      emit(RegisterFailedState(msg: onError.toString()));
      print(onError);
    });
  }

}
