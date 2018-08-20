package game.view.gui.components
{
   import engine.core.clipgui.ClipSprite;
   import feathers.controls.LayoutGroup;
   import flash.geom.Rectangle;
   
   public class ClipButtonLabeledUnderlined extends ClipButton
   {
       
      
      public var guiClipLabel:ClipLabel;
      
      public var underline:ClipSprite;
      
      public function ClipButtonLabeledUnderlined()
      {
         guiClipLabel = new ClipLabel(true);
         _container = new LayoutGroup();
         super();
      }
      
      public function initialize(param1:String, param2:Function) : void
      {
         label = param1;
         signal_click.add(param2);
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
         graphics.width = _loc2_.x + _loc2_.width;
         graphics.dispatchEventWith("resize");
      }
   }
}
