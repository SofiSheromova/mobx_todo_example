import 'package:mobx/mobx.dart';
import 'package:mobx_todo/domain/models/filter/visibility_filter.dart';
import 'package:mobx_todo/domain/repository/todos_repository.dart';
import 'package:mobx_todo/domain/models/operation/operation_status.dart';
import 'package:mobx_todo/presentation/ui/screens/todo/store/todo_store.dart';

part 'todo_list_store.g.dart';

class TodoListStore extends _TodoListStore with _$TodoListStore {
  TodoListStore(super.todosRepository);
}

abstract class _TodoListStore with Store {
  final TodosRepository _todosRepository;

  @observable
  OperationStatus<List<TodoStore>> todosLoading = const OperationStatus.loading();

  @observable
  ObservableList<TodoStore> todos = ObservableList<TodoStore>();

  @observable
  OperationStatus<void> todosSaving = const OperationStatus.data(null);

  @observable
  VisibilityFilter filter = VisibilityFilter.all;

  _TodoListStore(this._todosRepository) {
    _fetchTodos();
  }

  @computed
  ObservableList<TodoStore> get pendingTodos => ObservableList.of(todos.where((todo) => todo.done != true));
  @computed
  bool get hasPendingTodos => pendingTodos.isNotEmpty;

  @computed
  ObservableList<TodoStore> get completedTodos => ObservableList.of(todos.where((todo) => todo.done == true));
  @computed
  bool get hasCompletedTodos => completedTodos.isNotEmpty;

  @computed
  String get itemsDescription {
    if (todos.isEmpty) {
      return "There are no Todos here. Why don't you add one?.";
    }

    final suffix = pendingTodos.length == 1 ? 'todo' : 'todos';
    return '${pendingTodos.length} pending $suffix, ${completedTodos.length} completed';
  }

  @computed
  ObservableList<TodoStore> get visibleTodos {
    switch (filter) {
      case VisibilityFilter.pending:
        return pendingTodos;
      case VisibilityFilter.completed:
        return completedTodos;
      default:
        return todos;
    }
  }

  @computed
  bool get canRemoveAllCompleted => hasCompletedTodos && filter != VisibilityFilter.pending;

  @computed
  bool get canMarkAllCompleted => hasPendingTodos && filter != VisibilityFilter.completed;

  @action
  void addTodo(String description) {
    final todo = TodoStore(description);
    todos.add(todo);
  }

  @action
  void removeTodo(TodoStore todo) {
    todos.removeWhere((x) => x == todo);
  }

  @action
  void removeCompleted() {
    todos.removeWhere((todo) => todo.done);
  }

  @action
  void markAllAsCompleted() {
    for (final todo in todos) {
      todo.markAsCompleted();
    }
  }

  @action
  Future<void> _fetchTodos() async {
    todosLoading = const OperationStatus.loading();

    try {
      final fetchedTodos = await _todosRepository.getTodosData();
      todos.addAll(fetchedTodos.map(TodoStore.fromModel));

      todosLoading = OperationStatus.data(todos);
    } catch (err) {
      todosLoading = const OperationStatus.error();
    }
  }

  @action
  Future<void> saveTodos() async {
    todosSaving = const OperationStatus.loading();

    try {
      await _todosRepository.updateTodosData(todos.map((todo) => todo.model).toList());
      todosSaving = const OperationStatus.data(null);
    } catch (err) {
      todosSaving = const OperationStatus.error();
    }
  }
}
