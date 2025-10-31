import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehet_nono/features/children/data/model/child_model.dart';
import 'package:sehet_nono/features/children/data/repositories/children_repository.dart';

part 'children_state.dart';

class ChildrenCubit extends Cubit<ChildrenState> {
  ChildrenCubit({required this.childrenRepository}) : super(ChildrenInitial());
  final ChildrenRepository childrenRepository;

  Future<void> getChildren() async {
    emit(ChildrenLoading());
    final result = await childrenRepository.getChildren();
    result.fold(
      (l) => emit(ChildrenError(l.message)),
      (r) => emit(ChildrenSuccess(r)),
    );
  }

  Future<void> deleteChild(String childId) async {
    emit(ChildrenLoading());
    final result = await childrenRepository.deleteChild(childId);
    result.fold((l) => emit(ChildrenError(l)), (r) => emit(ChildrenSuccess(r)));
  }

  Future<void> updateChild(ChildModel child) async {
    emit(ChildrenLoading());
    final result = await childrenRepository.updateChild(child);
    result.fold((l) => emit(ChildrenError(l)), (r) => emit(ChildrenSuccess(r)));
  }

  Future<void> addChild(String name, String dateOfBirth, String gender) async {
    emit(ChildrenLoading());
    final result = await childrenRepository.addChild(name, dateOfBirth, gender);
    result.fold((l) => emit(ChildrenError(l)), (r) => emit(ChildrenSuccess(r)));
  }
}
