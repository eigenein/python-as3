package game.battle.gui
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabelNoFilter;
   import game.view.gui.components.ClipLayout;
   
   public class BattleSpeechBubble extends GuiClipNestedContainer
   {
      
      private static const FADE_AWAY_TIME:Number = 0.2;
       
      
      private var visibleTimeLeft:Number;
      
      public var background:GuiClipScale9Image;
      
      public var label:ClipLabelNoFilter;
      
      public var layout:ClipLayout;
      
      public function BattleSpeechBubble()
      {
         background = new GuiClipScale9Image();
         label = new ClipLabelNoFilter(true);
         layout = ClipLayout.verticalMiddleCenter(0,label);
         super();
         label.text = "dev nul";
      }
      
      public function set text(param1:String) : void
      {
         graphics.alpha = 1;
         visibleTimeLeft = 0.4 + param1.length * 0.1;
         label.maxWidth = 300;
         label.text = param1;
         label.validate();
         var _loc2_:Number = Math.max(label.width + 27,99);
         background.scale9Image.width = _loc2_;
         background.scale9Image.x = layout.x + layout.width * 0.5 - _loc2_ * 0.5;
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(visibleTimeLeft > 0)
         {
            visibleTimeLeft = visibleTimeLeft - param1;
            if(visibleTimeLeft < 0)
            {
               if(graphics.parent)
               {
                  graphics.parent.removeChild(graphics);
               }
            }
            else if(visibleTimeLeft < 0.2)
            {
               graphics.alpha = visibleTimeLeft / 0.2;
            }
         }
      }
   }
}
