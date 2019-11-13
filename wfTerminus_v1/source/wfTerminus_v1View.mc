using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class wfTerminus_v1View extends WatchUi.WatchFace {

	var ftb24 = null;
	var ftb60d= null;
	
    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    //    setLayout(Rez.Layouts.WatchFace(dc));
    	ftb24 = WatchUi.loadResource(Rez.Fonts.ftb24);
    	ftb60d = WatchUi.loadResource(Rez.Fonts.ftb60d);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get and show the current date and time
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var dateString = Lang.format( "$1$, $2$ $3$", [today.day_of_week, today.day, today.month]);
        var timeString = Lang.format( "$1$:$2$", [today.hour, today.min]);
        //clear screen
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(120, 100, ftb60d, timeString, Graphics.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(120, 60, ftb24, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
