package game.battle.view.animation
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import game.battle.view.hero.HeroView;
   import starling.display.DisplayObject;
   
   public class ContainerBattleFx extends BattleFx
   {
      
      private static const MARKER_CONTENT_IDENT:String = "MARKER_CONTENT";
      
      private static const MARKER_RECTANGULAR_MASK_IDENT:String = "MARKER_RECTANGULAR_MASK";
       
      
      protected var __skin:ClipSkin;
      
      protected var __targetHero:HeroView;
      
      public function ContainerBattleFx(param1:Boolean = false, param2:Number = 0)
      {
         super(param1,param2);
         __skin = new ClipSkin(null);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(__targetHero)
         {
            __targetHero.transform.removeContainerAnimation(this);
         }
      }
      
      override public function set clip(param1:Clip) : void
      {
         if(param1 == rootClip)
         {
            return;
         }
         rootClip = param1;
         events = null;
         __skin.setClip(param1);
      }
      
      public function get contentDisplayObject() : DisplayObject
      {
         return __skin.getMarkerDisplayObject("MARKER_CONTENT");
      }
      
      public function get contentState() : State
      {
         return __skin.getMarkerState(currentTime,"MARKER_CONTENT");
      }
      
      public function get maskState() : State
      {
         return __skin.getMarkerState(currentTime,"MARKER_RECTANGULAR_MASK");
      }
      
      override public function set targetHero(param1:HeroView) : void
      {
         __targetHero = param1;
         param1.transform.addContainerAnimation(this);
      }
      
      override public function advanceTime(param1:Number) : void
      {
         currentTime = currentTime + param1 * 60;
         if(currentTime > 10000000000)
         {
            currentTime = currentTime - 10000000000;
         }
         if(rootClip)
         {
            state.matrix = _assetAndSelfTransform;
            if(_loop != null && rootClip != _loop && currentTime >= rootClip.timeLine.length)
            {
               currentTime = currentTime - rootClip.timeLine.length;
               rootClip = _loop;
               _loop = null;
               __skin.setClip(rootClip);
            }
            if(events)
            {
               events.advanceFrame(currentTime);
            }
            if(_playOnce && currentTime >= rootClip.timeLine.length)
            {
               dispose();
            }
         }
      }
   }
}
