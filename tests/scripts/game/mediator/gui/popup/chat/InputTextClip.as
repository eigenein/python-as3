package game.mediator.gui.popup.chat
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.data.storage.DataStorage;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   
   public class InputTextClip extends GuiClipNestedContainer
   {
       
      
      public var button_save:ClipButtonLabeled;
      
      public var tf_input:ClipInput;
      
      public var input_bg:GuiClipScale9Image;
      
      public function InputTextClip()
      {
         button_save = new ClipButtonLabeled();
         tf_input = new ClipInput();
         input_bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_input.maxChars = DataStorage.rule.clanRule.maxDescriptionLength;
      }
   }
}
