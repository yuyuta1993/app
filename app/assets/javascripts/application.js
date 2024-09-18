// application.js
import Rails from "@rails/ujs"; // rails-ujsの機能をインポート
import { Application } from "stimulus";
import { definitionsFromContext } from "stimulus/webpack-helpers";

// rails-ujsを有効化
Rails.start();
console.log("Rails UJS has been started.");

// Stimulusの初期化
const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

application.debug = false;
window.Stimulus = application;

// CSRFトークンの確認
const csrfMetaTag = document.querySelector('meta[name="csrf-token"]');
if (csrfMetaTag) {
  const csrfToken = csrfMetaTag.content;
  console.log('CSRF Token:', csrfToken);
} else {
  console.error('CSRFトークンのmetaタグが見つかりませんでした。');
}
