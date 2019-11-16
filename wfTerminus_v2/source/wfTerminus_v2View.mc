using Toybox.WatchUi;
using Toybox.Graphics as			gfx;
using Toybox.System as				sys;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

class wfTerminus_v2View extends WatchUi.WatchFace {
//classic Terminus bold have only 4 sizes: 8x5(10), 10x7(16), 13x8(18), 15x10(24)
//need 13x8(18) in vector
		var ftb10 = null;
        var ftb16 = null;
        var ftb18 = null;
        var ftb24 = null;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        ftb10 = WatchUi.loadResource(Rez.Fonts.ftb10);
        ftb16 = WatchUi.loadResource(Rez.Fonts.ftb16);
        ftb18 = WatchUi.loadResource(Rez.Fonts.ftb18);
        ftb24 = WatchUi.loadResource(Rez.Fonts.ftb24);
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
        dc.drawText(120, 20, ftb10, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(120, 40, ftb16, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(120, 60, ftb18, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(120, 80, ftb24, dateString, Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(120, 100, ftb24, timeString, Graphics.TEXT_JUSTIFY_CENTER);    
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
