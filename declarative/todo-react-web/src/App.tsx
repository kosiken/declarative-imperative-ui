import { useEffect, useState } from "react";
import "./App.css";
import axios from "axios";
import { Todo } from "./types";
import Alert from "./components/alert";
import TodoItem from "./components/todo-item";
import Spinner from "./components/spinner";
import AddTodo from "./components/add-todo";

function App() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [alertMessage, setAlertMessage] = useState("");
  const showWarning = (message: string) => {
    setAlertMessage(message);
    setTimeout(() => {
      setAlertMessage("");
    }, 1000);
  };
  const onDelete = (id: number) => {
    showWarning(`Removing todo with id ${id}`);
    setTodos((prev) => prev.filter((todo) => todo.id !== id));
  };

  const onToggle = (id: number) => {
    setTodos((prev) =>
      prev.map((todo) => {
        if (todo.id === id) {
          return { ...todo, completed: !todo.completed };
        }
        return todo;
      })
    );
  };

  const addTodo = (title: string) => {
    const lastTodoId = todos[todos.length - 1].id;
    const newTodo = {
      userId: 1,
      id: lastTodoId + 1,
      title,
      completed: false,
    }
    setTodos((prev) => [newTodo, ...prev]);
  }
  useEffect(() => {
    const loadTodos = async () => {
      setIsLoading(true);
      try {
        const response = await axios.get<Todo[]>(
          "https://jsonplaceholder.typicode.com/todos/"
        );
        setTodos(response.data.slice(0, 14));
      } catch (error) {
        console.log(error);
        setAlertMessage("Failed to load todos");
      } finally {
        setIsLoading(false);
      }
    };
    loadTodos();
  }, []);



  return (
    <>
      <h1>Todo List - A simple todo list</h1>
      <div className="container">
        {isLoading ? <Spinner /> : null}
        {alertMessage ? <Alert message={alertMessage} /> : null}
        <div className="list-group todo-list-div" id="todo-list">
          {todos.map((todo) => (
            <TodoItem
              key={todo.id}
              {...todo}
              onDelete={() => {
                onDelete(todo.id);
              }}
              onToggle={() => {

                onToggle(todo.id);
              }}
            />
          ))}
        </div>
      </div>
      <AddTodo addTodo={addTodo} />
    </>
  );
}

export default App;
