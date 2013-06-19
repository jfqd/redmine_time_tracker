/*
 * This script updates the element 'id' with 'newContent' if the two contents differ
 */
function updateElementIfChanged(id, newContent) {
  el = $('#'+id);
  if (el.html() != newContent) { el.html(newContent); }
}