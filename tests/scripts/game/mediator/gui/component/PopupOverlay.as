package game.mediator.gui.component
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import starling.core.Starling;
   import starling.display.DisplayObjectContainer;
   
   public class PopupOverlay extends GuiClipNestedContainer
   {
      
      private static const TWEEN_DURATION:Number = 0.4;
      
      private static const TWEEN_EASING:String = "easeOut";
      
      private static var lastShownDarkAlpha:Number = 0;
      
      private static var lastShownImageAlpha:Number;
       
      
      public var image:ClipSprite;
      
      public var dark:ClipSprite;
      
      public function PopupOverlay()
      {
         super();
      }
      
      public function tweenShow() : void
      {
         dark.graphics.alpha = Math.max(0.75,lastShownDarkAlpha);
         Starling.juggler.removeTweens(dark.graphics);
         Starling.juggler.tween(dark.graphics,0.4,{
            "alpha":1,
            "transition":"easeOut",
            "onUpdate":saveLastDarkAlpha
         });
      }
      
      public function tweenHide(param1:DisplayObjectContainer) : void
      {
         graphics.touchable = false;
         param1.addChild(graphics);
         image.graphics.alpha = 1;
         dark.graphics.width = Starling.current.stage.stageWidth;
         dark.graphics.height = Starling.current.stage.stageHeight;
         image.graphics.width = Starling.current.stage.stageWidth;
         image.graphics.height = Starling.current.stage.stageHeight;
         Starling.juggler.tween(image.graphics,0.4 * 0.5,{
            "alpha":0,
            "transition":"easeOut"
         });
         dark.graphics.alpha = 1;
         Starling.juggler.tween(dark.graphics,0.4,{
            "alpha":0,
            "transition":"easeOut",
            "onComplete":removePartsFromParent,
            "onUpdate":saveLastDarkAlpha
         });
      }
      
      public function hide() : void
      {
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      protected function saveLastDarkAlpha() : void
      {
         lastShownDarkAlpha = dark.graphics.alpha;
      }
      
      private function removePartsFromParent() : void
      {
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
      }
   }
}
