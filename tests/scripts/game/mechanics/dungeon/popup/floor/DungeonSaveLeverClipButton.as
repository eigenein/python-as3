package game.mechanics.dungeon.popup.floor
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButtonWithHoverIntensity;
   import starling.animation.Tween;
   
   public class DungeonSaveLeverClipButton extends ClipButtonWithHoverIntensity
   {
       
      
      public var animation_enabled:GuiAnimation;
      
      public var animation_over:GuiAnimation;
      
      public var animation_handle:GuiAnimation;
      
      public var overlay:DungeonSaveLeverOverlayButton;
      
      public function DungeonSaveLeverClipButton()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation_handle.stop();
         overlay.tf_to_battle.text = Translate.translate("UI_DIALOG_ELEMENTS_ACTION_ACTIVATE");
         overlay.bg.graphics.alpha = 0.5;
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         .super.isEnabled = param1;
         animation_enabled.graphics.visible = param1;
         animation_over.graphics.visible = false;
         overlay.graphics.visible = param1;
         if(param1)
         {
            handler_hoverAnimationIntensitUpdate(0);
         }
      }
      
      override public function setupState(param1:String, param2:Boolean) : void
      {
         if(param2 && param1 == "down")
         {
            playClickSound();
            animation_handle.playLoop();
         }
         if(param1 == "hover" || param1 == "down")
         {
         }
         super.setupState(param1,param2);
         animation_over.graphics.visible = param1 == "hover" || param1 == "down";
      }
      
      override protected function handler_hoverAnimationIntensitUpdate(param1:int) : void
      {
         if(isEnabled)
         {
            animation_enabled.playbackSpeed = 1 + 2 * (param1 / 100);
         }
      }
      
      override protected function createTween() : void
      {
         tween = new Tween(this,0.5);
      }
   }
}
