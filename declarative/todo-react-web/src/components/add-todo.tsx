import React, { useState } from "react";

const AddTodo: React.FC<{ addTodo: (title: string) => void }> = ({addTodo}) => {
    const [title, setTitle] = useState('')
  return (
    <div>
      <div className="input-div container mt-3">
        <div className="mb-3">
          <label htmlFor="todo-list-text" className="form-label">
            Add Todo
          </label>
          <textarea value={title} onChange={(e) => setTitle(e.target.value)} className="form-control" id="todo-list-text"></textarea>
        </div>

        <button onClick={() => addTodo(title)} className="btn btn-primary" id="add-todo">
          Add Todo
        </button>
      </div>
    </div>
  );
};

export default AddTodo;
