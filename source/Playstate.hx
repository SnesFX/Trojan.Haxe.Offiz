import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.media.Sound;
import flash.media.SoundLoaderContext;
import flash.net.URLRequest;

class PlayState extends State {

    private var gif:Bitmap;
    private var sound:Sound;
    private var soundChannel:SoundChannel;
    private var bounds:Rectangle;

    public function new() {
        super();
        
        // Set up the stage
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        bounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        
        // Load the GIF file
        var gifData:BitmapData = Assets.getBitmapData("assets/idiot.gif");
        gif = new Bitmap(gifData);
        addChild(gif);
        
        // Load the MP3 file
        sound = new Sound();
        sound.load(new URLRequest("assets/idiot.mp3"), new SoundLoaderContext(1000));
        sound.addEventListener(Event.COMPLETE, onSoundLoaded);
    }
    
    private function onSoundLoaded(event:Event):Void {
        // Play the MP3 file infinitely
        soundChannel = sound.play(0, 99999);
    }
    
    override public function update(elapsed:Float):Void {
        // Update the GIF animation
        gif.bitmapData = gif.bitmapData.clone();
        
        // Move the window randomly when it reaches the edge of the screen
        var speed:Float = 300;
        var xMin:Float = bounds.left;
        var xMax:Float = bounds.right - width;
        var yMin:Float = bounds.top;
        var yMax:Float = bounds.bottom - height;
        if (x <= xMin || x >= xMax || y <= yMin || y >= yMax) {
            x = Math.random() * (xMax - xMin) + xMin;
            y = Math.random() * (yMax - yMin) + yMin;
        }
        x += speed * (Math.random() * 2 - 1) * elapsed;
        y += speed * (Math.random() * 2 - 1) * elapsed;
    }

}
