package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.data.storage.gear.GearItemDescription;
   import game.data.storage.resource.InventoryItemDescription;
   import game.mediator.gui.popup.hero.HeroGearListValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import idv.cjcat.signals.Signal;
   
   public class HeroPopupGearSetClip extends GuiClipNestedContainer
   {
       
      
      private var _signal_itemSelect:Signal;
      
      public var layout_color:ClipLayout;
      
      public var image_frame_1:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frame_2:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frame_3:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frame_4:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frame_5:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frame_6:HeroPopupGearSetInventoryItemIcon;
      
      public var image_frames:Vector.<HeroPopupGearSetInventoryItemIcon>;
      
      private var _data:HeroGearListValueObject;
      
      private var color:ClipLabel;
      
      public function HeroPopupGearSetClip()
      {
         _signal_itemSelect = new Signal(GearItemDescription);
         layout_color = ClipLayout.horizontalMiddleCentered(4);
         image_frame_1 = new HeroPopupGearSetInventoryItemIcon();
         image_frame_2 = new HeroPopupGearSetInventoryItemIcon();
         image_frame_3 = new HeroPopupGearSetInventoryItemIcon();
         image_frame_4 = new HeroPopupGearSetInventoryItemIcon();
         image_frame_5 = new HeroPopupGearSetInventoryItemIcon();
         image_frame_6 = new HeroPopupGearSetInventoryItemIcon();
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _data = null;
         var _loc1_:int = image_frames.length;
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = image_frames[_loc3_];
            _loc2_.signal_clickData.remove(handler_itemClicked);
            _loc3_++;
         }
         graphics.dispose();
         _signal_itemSelect.clear();
      }
      
      public function get signal_itemSelect() : Signal
      {
         return _signal_itemSelect;
      }
      
      public function get data() : HeroGearListValueObject
      {
         return _data;
      }
      
      public function set data(param1:HeroGearListValueObject) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         var _loc2_:int = param1.itemList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            image_frames[_loc3_].setItemDescription(param1.itemList[_loc3_]);
            _loc3_++;
         }
         if(color)
         {
            layout_color.removeChild(color.graphics);
            color = null;
         }
         color = HeroColorNumberClip.createAutoSize(param1.color,true);
         if(color)
         {
            layout_color.addChild(color);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         super.setNode(param1);
         image_frames = new Vector.<HeroPopupGearSetInventoryItemIcon>();
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc2_ = this["image_frame_" + _loc3_] as HeroPopupGearSetInventoryItemIcon;
            _loc2_.signal_clickData.add(handler_itemClicked);
            image_frames.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function handler_itemClicked(param1:InventoryItemDescription) : void
      {
         _signal_itemSelect.dispatch(param1 as GearItemDescription);
      }
   }
}
