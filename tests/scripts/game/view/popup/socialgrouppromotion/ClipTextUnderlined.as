package game.view.popup.socialgrouppromotion
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   
   public class ClipTextUnderlined extends GuiClipNestedContainer
   {
       
      
      public var guiClipLabel:ClipLabel;
      
      public var underline:ClipSprite;
      
      public function ClipTextUnderlined()
      {
         guiClipLabel = new ClipLabel(true);
         super();
      }
      
      public function get label() : String
      {
         return guiClipLabel.text;
      }
      
      public function set label(param1:String) : void
      {
         guiClipLabel.text = param1;
         guiClipLabel.validate();
         var _loc2_:Rectangle = guiClipLabel.bounds;
         underline.graphics.x = _loc2_.x;
         underline.graphics.width = _loc2_.width;
      }
   }
}
