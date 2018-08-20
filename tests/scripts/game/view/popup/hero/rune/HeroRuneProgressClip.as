package game.view.popup.hero.rune
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.utils.MathUtil;
   
   public class HeroRuneProgressClip extends GuiClipNestedContainer
   {
      
      private static const border:int = 5;
       
      
      private var maxWidth:int;
      
      private var minWidth:int;
      
      public var bg:GuiClipScale3Image;
      
      public var fill:GuiClipImage;
      
      public var green:GuiClipImage;
      
      public var green_middle:GuiClipImage;
      
      public var green_top:GuiClipImage;
      
      public function HeroRuneProgressClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         maxWidth = Math.round(bg.graphics.width - 5 * 2);
      }
      
      public function setupProgress(param1:Number) : void
      {
         fill.image.width = int(0.5 + minWidth + (maxWidth - minWidth) * MathUtil.clamp(param1,0,1));
      }
      
      public function setupGreenProgress(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(param1 > 1)
         {
            if(param1 >= 2)
            {
               green_middle.image.visible = true;
               green_middle.image.alpha = 0.5 - 0.3 / int(param1);
            }
            else
            {
               green_middle.image.visible = false;
            }
            _loc2_ = param1 < 2?0.4:0;
            param1 = Number(param1 % 1);
            if(param1 == 0)
            {
               param1 = 1;
            }
            green.image.x = fill.image.x + fill.image.width;
            green.image.width = Math.max(0,maxWidth - green.image.x + 5);
            green_top.image.x = fill.image.x;
            green_top.image.width = int(0.5 + minWidth + (maxWidth - minWidth) * param1);
            green.image.alpha = _loc2_;
            fill.image.alpha = _loc2_;
            green_top.image.visible = true;
         }
         else
         {
            green.image.x = fill.image.x + fill.image.width;
            _loc3_ = 0.5 + minWidth + (maxWidth - minWidth) * param1;
            green.image.width = _loc3_ - green.image.x + 5;
            green.image.alpha = 1;
            fill.image.alpha = 1;
            green_middle.image.visible = false;
            green_top.image.visible = false;
         }
      }
   }
}
