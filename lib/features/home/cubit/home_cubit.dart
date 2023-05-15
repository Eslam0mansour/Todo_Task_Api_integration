import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task/Core/di/di.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/home/cubit/home_staets.dart';
import 'package:todo_task/features/home/data/models/todo_data.dart';
import 'package:todo_task/features/home/data/models/todo_list_data.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<TodoListData> listsOfTodoLists = [];
  List<TodoData> listsOfTodos = [];

  Future<void> getTodoLists() async {
    emit(HomeLoadingState());
    sl<MyDio>().getData(endPoint: '/api/TodoLists').then((value) {
      if (value is ApiSuccess) {
        listsOfTodoLists = [];
        value.data.forEach((element) {
          listsOfTodoLists.add(TodoListData.fromJson(element));
          print(value.data[0]['title']);
          print(value.data);
          print(value);
        });
        print(
            'getTodoLists success----------------------------------------------');
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        print('${value.message}----------------------------------------------');
      }
    });
  }

//  add new Todo List
//  "id": "<integer>",
//   "title": "<string>",
//   "description": "<string>",
//   "icon": "<string>"
  Future<void> addNewTodoList({
    required String title,
    required String description,
    required String icon,
  }) async {
    emit(HomeLoadingState());
    sl<MyDio>().postData(
        endPoint: '/api/TodoLists', data: {
      "id": 0,
      "title": title,
      "description": description,
      "icon": icon
    }).then((value) {
      if (value is ApiSuccess) {
        getTodoLists();
        print(
            'addNewTodoList success----------------------------------------------');
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        print('${value.message}----------------------------------------------');
      }
    });
  }

  //  delete  Todo List , {{baseUrl}}/api/TodoLists/:id

  Future<void> deleteListOfTodos({required int id,
  }) async {
    emit(HomeLoadingState());
    sl<MyDio>().deleteData(
      endPoint: '/api/TodoLists/$id',).then((value) {
      if (value is ApiSuccess) {
        getTodoLists();
        print(
            'deleteListOfTodos success----------------------------------------------');
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        print('${value.message}----------------------------------------------');
      }
    });
  }

//  get todo list by id
//{
//     "id": 1,
//     "title": "aaaaaaaaaaaaaa",
//     "description": "aaaaaaaaaaaaaaaaaaaaa",
//     "icon": "aaaaaaaaaaaaaa",
//     "todos": [
//         {
//             "id": 1,
//             "name": "aaaaaaaaaaaa",
//             "description": "aaaaaaaaaaaaaaaaaa",
//             "isCompleted": false,
//             "createdOn": "2023-05-15T00:09:30.850892"
//         },
//         {
//             "id": 2,
//             "name": "aaaaaaaaaaaa",
//             "description": "aaaaaaaaaaaaaaaaaa",
//             "isCompleted": false,
//             "createdOn": "2023-05-15T00:10:30.0502202"
//         }
//     ]
// }

  Future<void> getTodoListById({required int id}) async {
    emit(HomeLoadingState());
    sl<MyDio>().getData(endPoint: '/api/TodoLists/$id').then((value) {
      if (value is ApiSuccess) {
        listsOfTodos = [];
        value.data['todos'].forEach((element) {
          listsOfTodos.add(TodoData.fromJson(element));
          print(value.data['todos'][0]['name']);
          print(value.data['todos']);
          print(value);
        });
        print(
            'getTodoListById success----------------------------------------------');
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        print('${value.message}----------------------------------------------');
      }
    });
  }

//  add new todo to list
//  {
//   "id": "<integer>",
//   "todoListId": "<integer>",
//   "name": "<string>",
//   "description": "<string>",
//   "isCompleted": "<boolean>"
// }

  Future<void> addNewTodoToList({
    required int todoListId,
    required String name,
    required String description,
  }) async {
    emit(HomeLoadingState());
    sl<MyDio>().postData(
        endPoint: '/api/Todoes', data: {
      "id": 0,
      "todoListId": todoListId,
      "name": name,
      "description": description,
      "isCompleted": false
    }).then((value) {
      if (value is ApiSuccess) {
        getTodoListById(id: todoListId);
        printResponse(value.data['todos']);
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        printError(value.message);
      }
    });
  }

  //  delete  Todo , {{baseUrl}}/api/Todoes/:id

  Future<void> deleteTodo({required int id, required int todoListId}) async {
    emit(HomeLoadingState());
    sl<MyDio>().deleteData(
      endPoint: '/api/Todoes/$id',).then((value) {
      if (value is ApiSuccess) {
        getTodoListById(id: todoListId);
        print(
            'deleteTodo success----------------------------------------------');
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        print('${value.message}----------------------------------------------');
      }
    });
  }

//  update todo bt id by put method

  Future<void> ubdateTodo({required int id,
    required int todoListId,
    required String name,
    required String description,
    required bool isCompleted}) async {
    emit(HomeLoadingState());
    sl<MyDio>().putData(
        endPoint: '/api/Todoes/$id', data: {
      "id": id,
      "todoListId": todoListId,
      "name": name,
      "description": description,
      "isCompleted": isCompleted
    }).then((value) {
      if (value is ApiSuccess) {
        getTodoListById(id: todoListId);
        emit(HomeSuccessState());
      } else if (value is ApiFailure) {
        emit(HomeErrorState(value.message));
        printError(value.message);
      }
    });
  }
}
