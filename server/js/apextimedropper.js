// APEX TimeDropper Functions
// Author: Erick Diaz
// Version: 1.0.1

//Global Namespace
var apexTimeDropper = {
  initTimeDropper: function(pItemId, pOptions, pLogging) {
    var vOptions = pOptions;
    var vLogging = pLogging;
    var vAutoswitch = vOptions.autoswitch;
    var vMeridians = vOptions.meridians;
    var vFormat = vOptions.format;
    var vMousewheel = vOptions.mousewheel;
    var vInitAnimation = vOptions.initAnimation;
    var vSetCurrentTime = vOptions.setCurrentTime;
    var vPrimaryColor = vOptions.primaryColor;
    var vTextColor = vOptions.textColor;
    var vBackgroundColor = vOptions.backgroundColor;
    var vBorderColor = vOptions.borderColor;

    if (vLogging) {
      console.log(pItemId + ' - apexTimeDropper.autoswitch: ' + vAutoswitch);
      console.log(pItemId + ' - apexTimeDropper.meridians: ' + vMeridians);
      console.log(pItemId + ' - apexTimeDropper.format: ' + vFormat);
      console.log(pItemId + ' - apexTimeDropper.mousewheel: ' + vMousewheel);
      console.log(pItemId + ' - apexTimeDropper.initAnimation: ' + vInitAnimation);
      console.log(pItemId + ' - apexTimeDropper.setCurrentTime: ' + vSetCurrentTime);
      console.log(pItemId + ' - apexTimeDropper.primaryColor: ' + vPrimaryColor);
      console.log(pItemId + ' - apexTimeDropper.textColor: ' + vTextColor);
      console.log(pItemId + ' - apexTimeDropper.backgroundColor: ' + vBackgroundColor);
      console.log(pItemId + ' - apexTimeDropper.borderColor: ' + vBorderColor);
    }

    $('#' + pItemId).timeDropper({
      "autoswitch" : vAutoswitch,
      "meridians" : vMeridians,
      "format" : vFormat,
      "mousewheel" : vMousewheel,
      "init_animation" : vInitAnimation,
      "setCurrentTime" : vSetCurrentTime,
      "primaryColor" : vPrimaryColor,
      "textColor" : vTextColor,
      "backgroundColor" : vBackgroundColor,
      "borderColor" : vBorderColor
    });

    var vTimeDropperId =  $('#' + pItemId);
    var vTimeDropperIndex = $(vTimeDropperId).index('.td-input');

    $('#td-clock-' + vTimeDropperIndex + ' .td-overlay').on('touchend mouseup', function() {
      $(vTimeDropperId).trigger('apex-timedropper-change');
    });

    
  }
};