package game.view.gui.components
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.extension.TextFieldDataExtension;
   import engine.core.clipgui.IGuiClip;
   import starling.display.DisplayObject;
   
   public class ClipFontColor implements IGuiClip
   {
       
      
      private var _fontColor:uint;
      
      public function ClipFontColor()
      {
         super();
      }
      
      public function get graphics() : DisplayObject
      {
         return null;
      }
      
      public function get fontColor() : uint
      {
         return _fontColor;
      }
      
      public function setNode(param1:Node) : void
      {
         _fontColor = TextFieldDataExtension.fromAsset(param1.clip.resource).getClipTextField(param1.clip).textColor;
      }
   }
}
