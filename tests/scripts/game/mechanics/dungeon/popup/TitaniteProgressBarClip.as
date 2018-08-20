package game.mechanics.dungeon.popup
{
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipProgressBar;
   
   public class TitaniteProgressBarClip extends ClipProgressBar
   {
       
      
      public var tf_progress_value:ClipLabel;
      
      public function TitaniteProgressBarClip()
      {
         tf_progress_value = new ClipLabel();
         super();
      }
      
      override protected function createFill() : void
      {
         bg = new GuiClipScale3Image();
         fill = new GuiClipScale3Image();
         minWidth = 13;
      }
      
      override protected function updateFillWidth() : void
      {
         super.updateFillWidth();
         tf_progress_value.text = value + "/" + maxValue;
      }
   }
}
