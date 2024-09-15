import Rails from "@rails/ujs";
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";
import '../../javascript/packs/favorite'

Rails.start();
console.log("Rails UJS has been started.");

const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

application.debug = false
window.Stimulus   = application

const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
console.log('CSRF Token:', csrfToken);

export { application }
