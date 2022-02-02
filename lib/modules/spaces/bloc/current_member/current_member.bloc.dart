

import 'package:demos_app/modules/spaces/bloc/current_member/current_member.event.dart';
import 'package:demos_app/modules/spaces/models/member.view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentMemberBloc extends Bloc<CurrentMemberEvent, MemberView?> {
  static final CurrentMemberBloc _currentMemberBloc = CurrentMemberBloc._internal();
  factory CurrentMemberBloc() => _currentMemberBloc;

  CurrentMemberBloc._internal(): super(null) {
    on<SetCurrentMemberEvent>((event, emit) => emit(event.memberView));
  }
}