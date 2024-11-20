import React from "react";
import { Todo } from "../types";

const TodoItem: React.FC<
  Todo & { onDelete: () => void; onToggle: (active: boolean) => void }
> = ({ id, title, completed, onDelete, onToggle }) => {
  const isActive = completed;
  return (
    <a
      onClick={() => {
        onToggle(!completed);
      }}
      data-todo-id="${todo.id}"
      className="list-group-item list-group-item-action d-flex flex-row  todo-item"
    >
      <div className="flex-fill cursor-pointer">
        <span
          className={
            isActive ? "todo-title text-decoration-line-through" : "todo-title"
          }
        >
          {title}
        </span>{" "}
        <input
          checked={isActive}
          type="checkbox"
          className="todo-checkbox"
          aria-label={`Checkbox for todo ${id}`}
        />
      </div>
      <span className="link-danger cursor-pointer" onClick={onDelete}>
        Remove Todo
      </span>
    </a>
  );
};

export default TodoItem;
