package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.filters.ColorMatrixFilter;
   
   public class DungeonDoorButtonBase extends ClipButton
   {
       
      
      protected var tween:Tween;
      
      public var tf_to_battle:ClipLabel;
      
      public var anim_2:GuiAnimation;
      
      public var glow:GuiAnimation;
      
      public var state_over:GuiAnimation;
      
      public var state_over_1:GuiAnimation;
      
      public var state_up:GuiAnimation;
      
      protected var _hoverAnimationIntensity:int = -1;
      
      public function DungeonDoorButtonBase()
      {
         tf_to_battle = new ClipLabel();
         anim_2 = new GuiAnimation();
         glow = new GuiAnimation();
         state_over = new GuiAnimation();
         state_over_1 = new GuiAnimation();
         state_up = new GuiAnimation();
         super();
         createTween();
      }
      
      public function get hoverAnimationIntensity() : int
      {
         return _hoverAnimationIntensity;
      }
      
      public function set hoverAnimationIntensity(param1:int) : void
      {
         if(_hoverAnimationIntensity == param1)
         {
            return;
         }
         _hoverAnimationIntensity = param1;
         adjustIntensity(state_over,param1);
         adjustIntensity(state_over_1,param1);
         adjustIntensity(state_up,100 - param1);
         adjustIntensity(glow,param1);
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_to_battle.text = Translate.translate("UI_TOWER_BATTLE_BUTTON");
         hoverAnimationIntensity = 0;
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         var _loc3_:* = null;
         if(param1 == "hover")
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",100);
            Starling.juggler.add(tween);
            _loc3_ = new ColorMatrixFilter();
            _loc3_.adjustBrightness(0.1);
         }
         else
         {
            tween.reset(this,tween.totalTime);
            tween.animate("hoverAnimationIntensity",0);
            Starling.juggler.add(tween);
         }
      }
      
      protected function adjustIntensity(param1:GuiAnimation, param2:int) : void
      {
         if(param1)
         {
            param1.graphics.alpha = param2 / 100;
            param1.graphics.visible = param2 > 0;
            if(param2 > 0 && !param1.isPlaying)
            {
               param1.play();
            }
            else if(param2 == 0 && param1.isPlaying)
            {
               param1.stop();
            }
         }
      }
      
      protected function createTween() : void
      {
         tween = new Tween(this,0.5);
      }
   }
}
