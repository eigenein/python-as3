package game.view.specialoffer.welcomeback
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClipLabelInContainer extends GuiClipNestedContainer
   {
       
      
      public var label:SpecialClipLabel;
      
      public function ClipLabelInContainer()
      {
         label = new SpecialClipLabel();
         super();
      }
      
      public function set text(param1:String) : void
      {
         label.text = param1;
      }
   }
}
