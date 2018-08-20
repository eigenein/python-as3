package game.view.popup.tower.screen
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class TowerScreenFloorListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      protected var tween:Tween;
      
      public var button_arrow:TowerScreenProceedButton;
      
      public var button:ClipButton;
      
      public var floor_number:ClipLabel;
      
      public var hero_container:GuiClipContainer;
      
      public var entrance_animation:GuiAnimation;
      
      public var flame_animation:GuiClipNestedContainer;
      
      private var _doorAlpha:Number = -1;
      
      public var layout_special_offer:ClipLayout;
      
      public function TowerScreenFloorListItemRendererClip()
      {
         tween = new Tween(this,1);
         floor_number = new ClipLabel();
         layout_special_offer = ClipLayout.none();
         super();
         createButton();
      }
      
      public function dispose() : void
      {
         if(button)
         {
            button.signal_click.clear();
         }
         if(button_arrow)
         {
            button_arrow.signal_click.clear();
         }
      }
      
      public function get doorAlpha() : Number
      {
         return _doorAlpha;
      }
      
      public function set doorAlpha(param1:Number) : void
      {
         if(_doorAlpha == param1)
         {
            return;
         }
         _doorAlpha = param1;
         entrance_animation.graphics.alpha = param1;
         if(param1 > 0)
         {
            entrance_animation.graphics.visible = true;
            entrance_animation.play();
         }
         else
         {
            entrance_animation.graphics.visible = false;
            entrance_animation.stop();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(hero_container)
         {
            hero_container.graphics.touchable = false;
         }
         if(entrance_animation)
         {
            doorAlpha = 0;
         }
      }
      
      public function closeExitDoor() : void
      {
         if(entrance_animation)
         {
            tween.reset(this,1.5);
            tween.animate("doorAlpha",0);
            Starling.juggler.add(tween);
         }
      }
      
      public function openExitDoor() : void
      {
         if(entrance_animation)
         {
            tween.reset(this,0.5);
            tween.animate("doorAlpha",1);
            Starling.juggler.add(tween);
         }
      }
      
      protected function createButton() : void
      {
         button = new TowerScreenFloorListItemRendererClipButton();
      }
   }
}
