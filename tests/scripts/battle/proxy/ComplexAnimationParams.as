package battle.proxy
{
   import battle.timeline.Timeline;
   import flash.geom.Rectangle;
   
   public class ComplexAnimationParams
   {
       
      
      public var timeline:Timeline;
      
      public var remove:Function;
      
      public var getTransform:Function;
      
      public var getTimeRelativeTransform:Function;
      
      public var endTime:Number;
      
      public var currentTime:Number;
      
      public var bounds:Rectangle;
      
      public function ComplexAnimationParams()
      {
      }
   }
}
