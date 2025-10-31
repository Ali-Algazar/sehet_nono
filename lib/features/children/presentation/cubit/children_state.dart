part of 'children_cubit.dart';

@immutable
sealed class ChildrenState {}

final class ChildrenInitial extends ChildrenState {}

final class ChildrenLoading extends ChildrenState {}

final class ChildrenSuccess extends ChildrenState {
  final List<ChildModel> children;

  ChildrenSuccess(this.children);
}

final class ChildrenError extends ChildrenState {
  final String message;

  ChildrenError(this.message);
}
