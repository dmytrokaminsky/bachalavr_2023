function getThemeForm(){
  var closeModal     = document.getElementById('modal_close');
  var themeModal     = document.getElementById('theme_modal');
  var themeErrors    = document.getElementById('theme_errors');
  var themeForm      = document.getElementById('new_theme_form');

  themeModal.classList.remove('d-none');

  closeModal.addEventListener('click', function() {


    themeModal.classList.add('d-none');
    themeErrors.innerHTML = "";
    themeForm.reset();
  });
};

function selectOnlyOneCheckbox(id){
  var myCheckbox = document.getElementsByClassName("answerCheckbox");
  Array.prototype.forEach.call(myCheckbox,function(el){
    el.checked = false;
  });
  id.checked = true;
}