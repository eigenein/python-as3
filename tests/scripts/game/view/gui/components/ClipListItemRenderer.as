package game.view.gui.components
{
   import flash.geom.Rectangle;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClipListItemRenderer extends ListItemRenderer
   {
       
      
      private var _item:IClipListItem;
      
      private var customBounds:Rectangle;
      
      public function ClipListItemRenderer(param1:IClipListItem)
      {
         super();
         this._item = param1;
         addChild(param1.graphics);
         if(param1 is IClipListItemCustomBounds)
         {
            customBounds = (param1 as IClipListItemCustomBounds).customBounds;
         }
         else
         {
            customBounds = param1.graphics.bounds;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_item)
         {
            _item.dispose();
         }
      }
      
      override public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         this.invalidate("selected");
         this.dispatchEventWith("change");
         _item.setSelected(param1);
      }
      
      override public function get pivotX() : Number
      {
         return customBounds.x;
      }
      
      override public function get pivotY() : Number
      {
         return customBounds.y;
      }
      
      override public function get width() : Number
      {
         return customBounds.width;
      }
      
      override public function get height() : Number
      {
         return customBounds.height;
      }
      
      public function get item() : IClipListItem
      {
         return _item;
      }
      
      override protected function commitData() : void
      {
         _item.setData(_data);
         _item.setSelected(_isSelected);
         if(item is IClipListItemCustomBounds)
         {
            customBounds = (item as IClipListItemCustomBounds).customBounds;
         }
         else
         {
            customBounds = item.graphics.bounds;
         }
      }
   }
}
