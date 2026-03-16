sealed class TestState {
  final List<Map> tasks;
  final bool isLoading;
  TestState({required this.tasks, this.isLoading = false});

}

class TestInitial extends TestState {
  TestInitial() : super(tasks: [], isLoading: false);
}
class TestLoading extends TestState {
  TestLoading() : super(tasks: [], isLoading: true);
}

class TestLoaded extends TestState {
  TestLoaded(List<Map> tasks) : super(tasks: tasks, isLoading: false);
}





class TestError extends TestState {
  final String error;
  TestError(this.error) : super(tasks: [], isLoading: false);
}


class TasksUpdate extends TestState {
  TasksUpdate(List<Map> tasks) : super(tasks: tasks, isLoading: true);
}