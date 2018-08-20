package game.view.gui.clanscreen
{
   import engine.core.clipgui.GuiAnimation;
   import game.assets.storage.AssetStorage;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   
   public class ClanScreenTransitionSpeedFx
   {
       
      
      private var container:DisplayObjectContainer;
      
      private var animation:GuiAnimation;
      
      private var directionUp:Boolean = true;
      
      private var fullSpeed:Number = 6;
      
      public function ClanScreenTransitionSpeedFx(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         if(AssetStorage.rsx.main_screen.data.getClipByName("clan_city_transition_animation"))
         {
            animation = AssetStorage.rsx.main_screen.create(GuiAnimation,"clan_city_transition_animation");
         }
      }
      
      public function show(param1:Number, param2:Number, param3:Boolean) : void
      {
         if(animation == null)
         {
            return;
         }
         Starling.juggler.removeTweens(animation.graphics);
         Starling.juggler.removeTweens(animation);
         if(param3 != this.directionUp)
         {
            this.directionUp = param3;
         }
         animation.playbackSpeed = (!!param3?fullSpeed:Number(-fullSpeed)) * 0.01;
         container.addChild(animation.graphics);
         animation.graphics.alpha = 0;
         Starling.juggler.tween(animation.graphics,param2,{
            "delay":param1,
            "alpha":1,
            "transition":"linear"
         });
         Starling.juggler.tween(animation.graphics,param2 * 2,{
            "delay":param1,
            "scaleY":1,
            "transition":"linear"
         });
         Starling.juggler.tween(animation,param2 * 1.2,{
            "delay":param1,
            "playbackSpeed":(!!param3?fullSpeed:Number(-fullSpeed)),
            "transition":"easeOut"
         });
      }
      
      public function hide(param1:Number = 0.2) : void
      {
         if(animation == null)
         {
            return;
         }
         Starling.juggler.removeTweens(animation.graphics);
         Starling.juggler.removeTweens(animation);
         Starling.juggler.tween(animation.graphics,param1,{
            "alpha":0,
            "scaleY":1,
            "onComplete":animation.graphics.removeFromParent
         });
         Starling.juggler.tween(animation,param1,{
            "playbackSpeed":(!!directionUp?fullSpeed:Number(-fullSpeed)) * 0.01,
            "transition":"linear"
         });
      }
   }
}
