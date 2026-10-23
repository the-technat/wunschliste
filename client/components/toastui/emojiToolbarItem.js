import { mdiEmoticonHappyOutline } from "@mdi/js";

// Plain unicode emojis (not shortcodes or images), so that they are the same
// characters a phone keyboard inserts. These are the "face-smiling" and
// "face-affection" groups of https://unicode.org/emoji/charts/full-emoji-list.html
// in the same order, leaving out emojis too new to be supported widely yet.
// prettier-ignore
const emojis = [
  "😀", "😃", "😄", "😁", "😆", "😅", "🤣", "😂",
  "🙂", "🙃", "🫠", "😉", "😊", "😇", "🥰", "😍",
  "🤩", "😘", "😗", "☺️", "😚", "😙", "🥲",
];

function createButton() {
  const button = document.createElement("button");
  button.type = "button";
  button.className = "toastui-editor-toolbar-icons emoji-toolbar-button";
  // Replace the sprite background of the default toolbar icons with our own icon
  button.style.backgroundImage = "none";
  button.innerHTML = `<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor"><path d="${mdiEmoticonHappyOutline}"/></svg>`;
  return button;
}

function createPopupBody(onSelect) {
  const body = document.createElement("div");
  body.className = "emoji-grid";
  for (const emoji of emojis) {
    const item = document.createElement("button");
    item.type = "button";
    item.className = "emoji-grid-item";
    item.textContent = emoji;
    item.addEventListener("click", () => onSelect(emoji));
    body.appendChild(item);
  }
  return body;
}

// Returns a toolbar item that opens a popup with common emojis and inserts the
// chosen one at the cursor. `getEditor` is called lazily as the toolbar item
// has to be created before the editor itself.
export function createEmojiToolbarItem(getEditor) {
  function onSelect(emoji) {
    const editor = getEditor();
    editor.eventEmitter.emit("closePopup");
    editor.focus();
    editor.insertText(emoji);
  }

  return {
    name: "emoji",
    tooltip: "Emoji",
    el: createButton(),
    popup: {
      className: "emoji-popup",
      body: createPopupBody(onSelect),
      style: { width: "auto" },
    },
  };
}
