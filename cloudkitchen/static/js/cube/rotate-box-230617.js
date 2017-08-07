var init = function() {
  var box = document.querySelector('.container-cube').children[0],
      showPanelButtons = document.querySelectorAll('#show-buttons button'),
      panelClassName = 'show-front',
      onButtonClick = function( event ){
        box.removeClassName('button');
        box.removeClassName( panelClassName );
        panelClassName = event.target.className;
        box.addClassName( panelClassName );
      };

  for (var i=0, len = showPanelButtons.length; i < len; i++) {
    showPanelButtons[i].addEventListener( 'click', onButtonClick, false);
  }
};

window.addEventListener( 'DOMContentLoaded', init, false);

console.log(document.querySelector('.container-cube').children[0])