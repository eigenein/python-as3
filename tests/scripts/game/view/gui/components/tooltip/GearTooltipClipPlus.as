package game.view.gui.components.tooltip
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class GearTooltipClipPlus extends GuiClipNestedContainer
   {
       
      
      public var tf_plus_amount:ClipLabel;
      
      public function GearTooltipClipPlus()
      {
         tf_plus_amount = new ClipLabel(true);
         super();
      }
   }
}
