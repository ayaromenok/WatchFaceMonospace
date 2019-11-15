using Toybox.System as 					sys;
using Toybox.Application.Storage as 	storage;
using Toybox.Graphics as 				gfx;

//storage.setValue("location", locationValue.toDegrees());
class pressureStorage {
	function init(){
		sys.println("pressStorage::init");
	}
	function testDravingContext(dc){
		sys.println("pressStorage::drawingContext");
		dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);        
        dc.drawText(120, 180, gfx.FONT_MEDIUM, "PS", Graphics.TEXT_JUSTIFY_CENTER);
	}
}