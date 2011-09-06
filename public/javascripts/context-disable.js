//<script language="JavaScript" type="text/javascript">
<!--
 
  // Setting "onlyOnImages" to "true" will disable right-clicking only for
  // images
  var onlyOnImages = false;
 
  // Detect the browser we have to handle with
  var isIE5 = document.all && document.getElementById;  // IE 5 or higher
  var isMoz = !isIE5 && document.getElementById;  // Mozilla/Firefox
 
  function cancelContextMenu(e) {
    // Here you can add additional code that is executed when the context menu
    // is blocked. For instance you can use the following code to display a
    // message to the user:
    //alert("Please respect our copyright. Thank you!");
 
    if (e && e.stopPropagation)
      e.stopPropagation();
 
    return false;
  }
 
  /* This function is fired every time a user clicks the right mouse button to
     open the browser's context menu. */
  function onContextMenu(e) {
    // Depending on the "onlyOnImages" variable the context menu is either
    // blocked for the complete page or only for <img> tags.
    if (!onlyOnImages
      || (isIE5 && event.srcElement.tagName == "IMG")
      || (IsMoz && e.target.tagName == "IMG")) {
      return cancelContextMenu(e);
    }
  }
 
  if (document.getElementById) {
    // Register event handler
    document.oncontextmenu = onContextMenu;
  }
 
-->
//</script>