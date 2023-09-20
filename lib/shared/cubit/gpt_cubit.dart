import 'package:chat_gpt/shared/cubit/gpt_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GptCubit extends Cubit<GptState> {
  GptCubit() : super(GptInitialState());
  static GptCubit get(context) => BlocProvider.of(context);
}
