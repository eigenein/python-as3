package battle.proxy
{
   import battle.skills.Context;
   import battle.timeline.Timeline;
   import flash.Boot;
   import flash.geom.Rectangle;
   
   public class ViewTransformProvider
   {
      
      public static var nullRectangle:Rectangle = new Rectangle();
       
      
      public var zBackOffset:Number;
      
      public var timeline:Timeline;
      
      public var switchAsset:String;
      
      public var startTime:Number;
      
      public var setTime:Number;
      
      public var setPlayingOnce:Boolean;
      
      public var playOnce:String;
      
      public var duration:Number;
      
      public var assetBounds:Rectangle;
      
      public var _remove:Function;
      
      public var _progress:Function;
      
      public var _getTransform:Function;
      
      public function ViewTransformProvider(param1:* = undefined, param2:Number = 1.0E100, param3:Number = 20)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         setPlayingOnce = false;
         setTime = -1;
         zBackOffset = 20;
         playOnce = null;
         switchAsset = null;
         assetBounds = ViewTransformProvider.nullRectangle;
         if(param1.hasOwnProperty("getTransform"))
         {
            _getTransform = param1.getTransform;
         }
         if(param1.hasOwnProperty("getProgress"))
         {
            _progress = param1.getProgress;
         }
         if(param1.hasOwnProperty("finish"))
         {
            _remove = param1.finish;
         }
         timeline = Context.engine.displayTimeline;
         duration = param2;
         startTime = timeline.time;
         zBackOffset = param3;
      }
      
      public function init(param1:Rectangle) : void
      {
         assetBounds = param1;
      }
      
      public function hasProgress() : Boolean
      {
         return _progress != null;
      }
      
      public function hasDefinedDuration() : Boolean
      {
         return duration != Timeline.INFINITY_TIME;
      }
      
      public function getTransform() : ViewTransform
      {
         if(timeline.time > Number(startTime + duration))
         {
            if(_remove != null)
            {
               _remove(this);
            }
            return null;
         }
         if(_getTransform != null)
         {
            return _getTransform(this);
         }
         return null;
      }
      
      public function getRelativeTime() : Number
      {
         var _loc1_:Number = (timeline.time - startTime) / duration;
         if(_loc1_ > 1)
         {
            return 1;
         }
         if(_loc1_ < 0)
         {
            return 0;
         }
         return _loc1_;
      }
      
      public function getProgress() : Number
      {
         return Number(_progress(this));
      }
      
      public function getLifetime() : Number
      {
         return timeline.time - startTime;
      }
      
      public function getDuration() : Number
      {
         return duration;
      }
   }
}
