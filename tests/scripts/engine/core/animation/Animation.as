package engine.core.animation
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.events.ClipEventTimeline;
   import com.progrestar.framework.ares.extension.sounds.ClipSoundEvent;
   import com.progrestar.framework.ares.extension.sounds.IClipSoundEventHandler;
   import com.progrestar.framework.ares.starling.ClipImageCache;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import com.progrestar.framework.ares.utils.ClipUtils;
   import engine.core.clipgui.ITimelineAnimation;
   import flash.geom.Matrix;
   import game.battle.view.BattleSoundStarlingEventData;
   
   public class Animation implements IClipSoundEventHandler, ITimelineAnimation
   {
      
      public static const playbackFps:Number = 60;
       
      
      public const state:State = new State();
      
      protected const rootNode:StarlingClipNode = StarlingClipNode.create(new ZSortedSprite());
      
      protected var rootClip:Clip;
      
      protected var events:ClipEventTimeline;
      
      protected var currentTime:Number;
      
      public function Animation(param1:Clip, param2:Matrix = null, param3:Number = 0)
      {
         super();
         rootClip = param1;
         state.matrix = param2;
         (rootNode.graphics as ZSortedSprite).z = param3;
         currentTime = 0;
      }
      
      public function dispose() : void
      {
         rootClip = null;
         rootNode.dispose();
      }
      
      public function get graphics() : ZSortedSprite
      {
         return rootNode.graphics as ZSortedSprite;
      }
      
      public function get currentPosition() : Number
      {
         return currentTime;
      }
      
      public function get completed() : Boolean
      {
         if(rootClip)
         {
            return currentTime >= rootClip.timeLine.length - 1;
         }
         return true;
      }
      
      public function setFrame(param1:int) : void
      {
         currentTime = param1;
         if(rootClip)
         {
            rootNode.setup(rootClip,state,currentTime);
            if(events)
            {
               events.skipTo(param1);
            }
         }
      }
      
      public function get length() : Number
      {
         if(rootClip.timeLine == null)
         {
            ClipImageCache.disposedClipError("Animation",rootClip.className);
            return 0;
         }
         return rootClip.timeLine.length;
      }
      
      public function set transform(param1:Matrix) : void
      {
         rootNode.setTransformationMatrix(param1);
         state.matrix = param1;
      }
      
      public function get transform() : Matrix
      {
         return state.matrix;
      }
      
      public function get hasAnimation() : Boolean
      {
         if(rootClip == null)
         {
            return false;
         }
         return ClipUtils.doesClipHasNestedAnimation(rootClip);
      }
      
      public function advanceTime(param1:Number) : void
      {
         currentTime = currentTime + param1 * 60;
         if(currentTime > 10000000000)
         {
            currentTime = currentTime - 10000000000;
         }
         if(rootClip)
         {
            rootNode.setup(rootClip,state,currentTime);
            if(events)
            {
               events.advanceFrame(currentTime);
            }
         }
      }
      
      public function advanceTimeTo(param1:Number) : void
      {
         this.currentTime = param1;
         rootNode.setup(rootClip,state,param1);
         if(events)
         {
            events.advanceFrame(param1);
         }
      }
      
      public function setClip(param1:Clip, param2:Matrix, param3:Number = 0) : void
      {
         if(param1 != rootClip)
         {
            rootClip = param1;
            graphics.z = param3;
         }
         rootNode.setTransformationMatrix(param2);
         state.matrix = param2;
         events = null;
      }
      
      public function setParent(param1:ZSortedSprite) : void
      {
         param1.addChild(rootNode.graphics);
      }
      
      public function playSoundsTo(param1:IClipSoundEventHandler) : void
      {
         if(!rootClip)
         {
            return;
         }
         events = ClipEventTimeline.merge(events,ClipEventTimeline.getSoundEventsTimeline(rootClip.resource,rootClip,param1));
      }
      
      public function playSoundsToEvent() : void
      {
         if(!rootClip)
         {
            return;
         }
         events = ClipEventTimeline.merge(events,ClipEventTimeline.getSoundEventsTimeline(rootClip.resource,rootClip,this));
      }
      
      public function onSoundEvent(param1:ClipSoundEvent) : void
      {
         rootNode.graphics.dispatchEventWith("SOUND",true,BattleSoundStarlingEventData.create(param1,rootNode.graphics));
      }
   }
}
