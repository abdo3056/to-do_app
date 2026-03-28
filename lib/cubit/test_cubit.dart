import 'package:bloc/bloc.dart';
import 'package:my_app/cubit/test_state.dart';
import 'package:my_app/sqdb.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(TestInitial());

  SqlDB sqlDB = SqlDB();


  Future<void>  getTasks(String category) async {
    emit(TestLoading());
    try {
      List<Map> tasks = await sqlDB.readData(category);
      emit(TestLoaded(tasks));
    } catch (e) {
      emit(TestError(e.toString()));
    }

  }

  Future <void> addTask(String task, String category) async {
    if(task.isEmpty) {
      return;
    }
    await sqlDB.insertData(task, category);
    await getTasks(category);
  }

  Future <void> editTask(String task, int id, String category) async {
    if (task.isEmpty) return;
    await sqlDB.updateData(task, id);
    await getTasks(category);
  }

  Future <void> toggleStatus(int id, bool isDone, String category) async {
    await sqlDB.updateStatus(id, isDone? 1 : 0);
    await getTasks(category);
  }

  Future <void> deleteTask(int id, String category) async {
    await sqlDB.deleteData(id);
    await getTasks(category);

  }

  Future <void> removeAll(String category) async {
    await sqlDB.removeAll(category);
    await getTasks(category);
  }

  }