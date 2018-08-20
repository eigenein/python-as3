package game.view.popup.tower
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.tower.TowerBuffDescription;
   import game.view.gui.components.ClipLabel;
   
   public class TowerBuffIcon extends GuiClipNestedContainer
   {
       
      
      public var bg_empty:ClipSprite;
      
      public var bg_frame:ClipSprite;
      
      public var image_icon:GuiClipImage;
      
      public var tf_value:ClipLabel;
      
      private var _data:TowerBuffDescription;
      
      public function TowerBuffIcon()
      {
         bg_empty = new ClipSprite();
         bg_frame = new ClipSprite();
         image_icon = new GuiClipImage();
         tf_value = new ClipLabel();
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function get data() : TowerBuffDescription
      {
         return _data;
      }
      
      public function set data(param1:TowerBuffDescription) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         bg_empty.graphics.visible = param1 == null;
         var _loc2_:* = param1 != null;
         image_icon.graphics.visible = _loc2_;
         bg_frame.graphics.visible = _loc2_;
         if(param1)
         {
            image_icon.image.texture = param1.icon;
         }
      }
   }
}
