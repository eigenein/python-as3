package game.view.popup.clan.editicon
{
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipList;
   import idv.cjcat.signals.Signal;
   
   public class ClanEditIconItemPicker
   {
       
      
      private var view:ClipList;
      
      private var buttonLeft:ClipButton;
      
      private var buttonRight:ClipButton;
      
      public const signal_selected:Signal = new Signal(Object);
      
      public function ClanEditIconItemPicker(param1:ListCollection, param2:*, param3:ClipList, param4:ClipButton, param5:ClipButton)
      {
         super();
         this.view = param3;
         this.buttonLeft = param4;
         this.buttonRight = param5;
         param3.list.dataProvider = param1;
         param3.list.selectedItem = param2;
         param3.signal_itemSelected.add(handler_itemSelected);
         param3.list.clipContent = true;
         param3.list.verticalScrollPolicy = "off";
         param3.list.horizontalScrollPolicy = "off";
         var _loc6_:HorizontalLayout = new HorizontalLayout();
         param3.list.layout = _loc6_;
         param4.signal_click.add(handler_left);
         param5.signal_click.add(handler_right);
      }
      
      private function handler_itemSelected(param1:*) : void
      {
         signal_selected.dispatch(param1);
         view.list.selectedItem = param1;
      }
      
      private function handler_left() : void
      {
         var _loc2_:List = this.view.list;
         var _loc1_:Number = _loc2_.horizontalScrollPosition - _loc2_.pageWidth;
         _loc2_.scrollToPosition(_loc1_ < _loc2_.minHorizontalScrollPosition?_loc2_.minHorizontalScrollPosition:Number(_loc1_),NaN,0.2);
      }
      
      private function handler_right() : void
      {
         var _loc2_:List = this.view.list;
         var _loc1_:Number = _loc2_.horizontalScrollPosition + _loc2_.pageWidth;
         _loc2_.scrollToPosition(_loc1_ > _loc2_.maxHorizontalScrollPosition?_loc2_.maxHorizontalScrollPosition:Number(_loc1_),NaN,0.2);
      }
   }
}
