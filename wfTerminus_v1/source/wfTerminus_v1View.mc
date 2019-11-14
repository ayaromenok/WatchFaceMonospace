using Toybox.WatchUi;
using Toybox.Graphics as gfx;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.SensorHistory;

class wfTerminus_v1View extends WatchUi.WatchFace {

	var ftb24 = null;
	var ftb60d= null;
	
    function initialize() {
        WatchFace.initialize();
    }
    
    function showPressure(dc){
    	if ((Toybox has :SensorHistory) && (Toybox.SensorHistory has :getPressureHistory)){
    		System.println("showPressure");
    		//looks liks barometer perions is 120sec or 30 measures in a hour 
    		//but can't be more than 180 for VA3
			//value appear in mm, float, x100
    		var numIters = 180;
    		var numIters_3 = numIters/3;
    		var posX = 90;
    		var posY = 190;
    		var sizeY = 30;
    		//var sensorIter = Toybox.SensorHistory.getPressureHistory({:order=>SensorHistory.ORDER_OLDEST_FIRST, :period=>new Time.Duration(timeH * Time.Gregorian.SECONDS_PER_HOUR)});
    		var sensorIter = Toybox.SensorHistory.getPressureHistory({:order=>SensorHistory.ORDER_OLDEST_FIRST, :period=>numIters});
    		
    		if (sensorIter != null) {
    			var prMin = sensorIter.getMin();
    			var prMax = sensorIter.getMax();
    			var range = prMax - prMin;
    			var scale = 1.0;
    			//System.println(sensorIter.get().data);
    			if (range > sizeY){
    				scale = (sizeY/range);
    			}
    			var ar = [];
    			var tmp = 0;
    			ar.add([posX,posY]);
    			for (var i=0; i<numIters_3; i++){
    				//System.println(sensorIter.next().data);
    				tmp = sensorIter.next().data;
    				//need to find to use only 1/3 of values    				
    				ar.add([posX+i,(posY-(tmp-prMin)*scale)]);
    				System.println(i);
    				//use 1/3 of 180 values due to limit of dc.fillPolygon
    				sensorIter.next();
    				sensorIter.next();    				
    			}
    			ar.add([posX+numIters_3,posY]);
    			ar.add([posX,posY]);
    			System.println(ar.toString());
    			System.print("array size:");
    			System.println(ar.size().toString());
    			dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
    			//points array must be 64 or smaller.
    			dc.fillPolygon(ar);
    			dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    			dc.drawText(posX, posY, ftb24, (prMin/100).format("%04d").toString(), Graphics.TEXT_JUSTIFY_LEFT);
    			dc.drawText(posX, posY-sizeY, ftb24, (prMax/100).format("%04d").toString(), Graphics.TEXT_JUSTIFY_LEFT);
			}
    	} else {
    		System.println("Can't dsiplay Pressure History");
    	}
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
        
		showPressure(dc);
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
