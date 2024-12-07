import 'package:flutter_bloc/flutter_bloc.dart';
import 'web_view_state.dart';

class WebViewCubit extends Cubit<WebViewState> {
  WebViewCubit() : super(const WebViewState());

  void updateUrl(String url) {
    emit(state.copyWith(url: url));
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void setProgress(double progress) {
    emit(state.copyWith(progress: progress));
  }

  void setError(bool hasError) {
    emit(state.copyWith(hasError: hasError));
  }
}
