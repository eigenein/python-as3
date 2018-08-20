package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import starling.filters.BlurFilter;
   
   public class UltTitleView extends GuiClipNestedContainer
   {
      
      private static var TEXT_DURATION:Number = 1.6;
      
      private static var FADE_AWAY_TIME:Number = 0.22;
       
      
      private var textList:Vector.<String>;
      
      private var currentTextTimeLeft:Number;
      
      public var label:ClipLabel;
      
      public function UltTitleView()
      {
         textList = new Vector.<String>();
         label = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         setAlpha(0);
         graphics.touchable = false;
         if(label.filter)
         {
            label.filter.dispose();
         }
         label.filter = BlurFilter.createDropShadow(0,0,0,1,4,0.4);
         label.includeInLayout = false;
         label.validate();
      }
      
      public function addTitle(param1:String) : void
      {
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         if(textList.length > 0)
         {
            textList.push(param1);
         }
         else
         {
            startTitle(param1);
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(currentTextTimeLeft > 0)
         {
            currentTextTimeLeft = currentTextTimeLeft - param1;
            if(currentTextTimeLeft <= 0)
            {
               setAlpha(0);
            }
            else if(currentTextTimeLeft < FADE_AWAY_TIME)
            {
               _loc2_ = 1 - currentTextTimeLeft / FADE_AWAY_TIME;
               setAlpha(1 - _loc2_ * _loc2_);
            }
         }
         else if(textList.length > 0)
         {
            startTitle(textList.shift());
         }
      }
      
      protected function startTitle(param1:String) : void
      {
         currentTextTimeLeft = TEXT_DURATION;
         label.text = param1;
         setAlpha(1);
      }
      
      protected function setAlpha(param1:Number) : void
      {
         if(textList.length > 0)
         {
            graphics.alpha = 1;
         }
         else
         {
            graphics.alpha = param1;
         }
         label.alpha = param1 * param1;
      }
   }
}
