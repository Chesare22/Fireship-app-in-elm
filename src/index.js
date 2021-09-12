import "./main.css";
import { Elm } from "./Main.elm";
import * as serviceWorker from "./serviceWorker";

const initialTodoList = JSON.parse(localStorage.getItem("todos")) || [];

const app = Elm.Main.init({
  node: document.getElementById("root"),
  flags: initialTodoList,
});

app.ports.saveChanges.subscribe((todoList) => {
  localStorage.setItem("todos", JSON.stringify(todoList));
});
