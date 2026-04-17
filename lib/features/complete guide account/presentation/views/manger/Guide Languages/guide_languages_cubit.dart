import 'package:beyond_the_pramids/core/network/api_execptions.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/data/repo/complete_guide_account_repo.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/language_selector.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';

part 'guide_languages_state.dart';

class GuideLanguagesCubit extends Cubit<GuideLanguagesState> {
  GuideLanguagesCubit(this._repo) : super(GuideLanguagesInitial());
  final CompleteGuideAccountRepo _repo;

  Future<void> submitLanguages(List<LanguageEntry> languages) async {
    // ✅ Validate - لازم لغة واحدة على الأقل
    if (languages.isEmpty) {
      emit(GuideLanguagesError('val_add_language'.tr()));
      return;
    }

    // ✅ Validate كل لغة عندها language و level
    for (final lang in languages) {
      if (lang.language == null || lang.language!.isEmpty) {
        emit(GuideLanguagesError('val_select_all_languages'.tr()));
        return;
      }
      if (lang.level == null || lang.level!.isEmpty) {
        emit(GuideLanguagesError('val_select_all_levels'.tr()));
        return;
      }
    }

    emit(GuideLanguagesLoading());
    try {
      // ✅ حوّل الـ LanguageEntry لـ Map
      final languagesList =
          languages
              .map((e) => {"language": e.language!, "level": e.level!})
              .toList();

      final result = await _repo.updateLanguages(languages: languagesList);

      if (result['success'] == true) {
        emit(
          GuideLanguagesSuccess(result['message'] ?? 'success_languages'.tr()),
        );
      } else {
        emit(GuideLanguagesError('error_languages'.tr()));
      }
    } on ApiException catch (e) {
      emit(GuideLanguagesError(e.message));
    } catch (e) {
      emit(GuideLanguagesError(e.toString()));
    }
  }
}
