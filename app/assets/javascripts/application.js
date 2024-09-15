import Rails from "@rails/ujs";
import { Application } from "stimulus";
// import { definitionsFromContext } from "stimulus/webpack-helpers";
import '../../javascript/packs/favorite'

Rails.start();
console.log("Rails UJS has been started.");

const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

application.debug = false;
window.Stimulus = application;

// CSRFトークンが存在するか確認
const csrfMetaTag = document.querySelector('meta[name="csrf-token"]');
if (csrfMetaTag) {
  const csrfToken = csrfMetaTag.content;
  console.log('CSRF Token:', csrfToken);
} else {
  console.error('CSRFトークンのmetaタグが見つかりませんでした。');
}

export { application };
