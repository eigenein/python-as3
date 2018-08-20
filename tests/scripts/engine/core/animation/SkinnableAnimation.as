package engine.core.animation
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import flash.geom.Matrix;
   import starling.display.DisplayObject;
   
   public class SkinnableAnimation extends Animation
   {
       
      
      protected var skin:ClipSkin;
      
      public function SkinnableAnimation(param1:Clip, param2:Matrix = null, param3:Number = 0)
      {
         super(param1,param2,param3);
         skin = new ClipSkin(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function advanceTime(param1:Number) : void
      {
         currentTime = currentTime + param1 * 60;
         var _loc2_:int = currentTime;
         if(rootClip)
         {
            rootNode.setup(rootClip,state,_loc2_,null,skin);
         }
      }
      
      override public function advanceTimeTo(param1:Number) : void
      {
         this.currentTime = param1;
         if(rootClip)
         {
            rootNode.setup(rootClip,state,param1,null,skin);
            if(events)
            {
               events.advanceFrame(param1);
            }
         }
      }
      
      public function getMarkerDisplayObject(param1:String) : DisplayObject
      {
         return skin.getMarkerDisplayObject(param1);
      }
      
      public function setContent(param1:Clip, param2:String) : void
      {
         skin.applySkinPart(param2,param1);
      }
      
      public function setNativeContentPart(param1:DisplayObject, param2:String) : void
      {
         skin.applySkinPart(param2,param1);
      }
      
      override public function playSoundsTo(param1:IClipSoundEventHandler) : void
      {
         if(rootClip == null)
         {
            return;
         }
         skin.useSoundsFromAsset(rootClip.resource,param1);
      }
   }
}
