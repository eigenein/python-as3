package feathers.controls.renderers
{
   import feathers.controls.List;
   import feathers.skins.IStyleProvider;
   
   public class DefaultListItemRenderer extends BaseDefaultItemRenderer implements IListItemRenderer
   {
      
      public static const ICON_POSITION_TOP:String = "top";
      
      public static const ICON_POSITION_RIGHT:String = "right";
      
      public static const ICON_POSITION_BOTTOM:String = "bottom";
      
      public static const ICON_POSITION_LEFT:String = "left";
      
      public static const ICON_POSITION_MANUAL:String = "manual";
      
      public static const ICON_POSITION_LEFT_BASELINE:String = "leftBaseline";
      
      public static const ICON_POSITION_RIGHT_BASELINE:String = "rightBaseline";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const ACCESSORY_POSITION_TOP:String = "top";
      
      public static const ACCESSORY_POSITION_RIGHT:String = "right";
      
      public static const ACCESSORY_POSITION_BOTTOM:String = "bottom";
      
      public static const ACCESSORY_POSITION_LEFT:String = "left";
      
      public static const ACCESSORY_POSITION_MANUAL:String = "manual";
      
      public static const LAYOUT_ORDER_LABEL_ACCESSORY_ICON:String = "labelAccessoryIcon";
      
      public static const LAYOUT_ORDER_LABEL_ICON_ACCESSORY:String = "labelIconAccessory";
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var _index:int = -1;
      
      public function DefaultListItemRenderer()
      {
         super();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return DefaultListItemRenderer.globalStyleProvider;
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(param1:int) : void
      {
         this._index = param1;
      }
      
      public function get owner() : List
      {
         return List(this._owner);
      }
      
      public function set owner(param1:List) : void
      {
         var _loc2_:* = null;
         if(this._owner == param1)
         {
            return;
         }
         if(this._owner)
         {
            this._owner.removeEventListener("scrollStart",owner_scrollStartHandler);
            this._owner.removeEventListener("scrollComplete",owner_scrollCompleteHandler);
         }
         this._owner = param1;
         if(this._owner)
         {
            _loc2_ = List(this._owner);
            this.isSelectableWithoutToggle = _loc2_.isSelectable;
            if(_loc2_.allowMultipleSelection)
            {
               this.isToggle = true;
            }
            this._owner.addEventListener("scrollStart",owner_scrollStartHandler);
            this._owner.addEventListener("scrollComplete",owner_scrollCompleteHandler);
         }
         this.invalidate("data");
      }
      
      override public function dispose() : void
      {
         this.owner = null;
         super.dispose();
      }
   }
}
