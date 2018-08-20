package game.mechanics.grand.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class GrandTeamGatherTeamNumber extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public function GrandTeamGatherTeamNumber()
      {
         tf_label = new ClipLabel();
         super();
      }
      
      public function set text(param1:String) : void
      {
         tf_label.text = param1;
         tf_label.x = "37".indexOf(param1) == -1?12:13;
      }
   }
}
