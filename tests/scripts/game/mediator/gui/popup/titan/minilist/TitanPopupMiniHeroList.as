package game.mediator.gui.popup.titan.minilist
{
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import starling.events.Event;
   
   public class TitanPopupMiniHeroList extends List
   {
       
      
      private var parentClipLayout:ClipLayout;
      
      private var button_left:ClipButton;
      
      private var button_right:ClipButton;
      
      public function TitanPopupMiniHeroList(param1:ClipLayout, param2:ClipButton, param3:ClipButton)
      {
         super();
         this.button_right = param3;
         this.button_left = param2;
         this.parentClipLayout = param1;
      }
      
      override public function set selectedItem(param1:Object) : void
      {
         .super.selectedItem = param1;
         scrollToDisplayIndex(selectedIndex,0.1);
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid("pendingScroll"))
         {
            _loc2_ = !isNaN(_targetHorizontalScrollPosition) && _targetHorizontalScrollPosition > 2 || pendingHorizontalPageIndex != -1 && pendingHorizontalPageIndex >= 0;
            button_left.isEnabled = _loc2_;
            _loc1_ = !isNaN(_targetHorizontalScrollPosition) && _targetHorizontalScrollPosition + 2 < maxHorizontalScrollPosition || pendingHorizontalPageIndex != -1 && pendingHorizontalPageIndex <= horizontalPageCount || horizontalScrollPosition == 0;
            button_right.isEnabled = _loc1_;
         }
      }
      
      override public function set dataProvider(param1:ListCollection) : void
      {
         .super.dataProvider = param1;
         if(!param1)
         {
            return;
         }
         if(dataProvider.length <= 9)
         {
            width = NaN;
            button_left.graphics.visible = false;
            button_right.graphics.visible = false;
            parentClipLayout.addChild(this);
         }
         else
         {
            width = 645;
            parentClipLayout.addChild(button_left.graphics);
            button_left.signal_click.add(scrollLeft);
            parentClipLayout.addChild(this);
            parentClipLayout.addChild(button_right.graphics);
            button_right.signal_click.add(scrollRight);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         layout = _loc1_;
         _loc1_.padding = 2;
         _loc1_.gap = -2;
         itemRendererType = TitanPopupMiniHeroListItem;
         addEventListener("rendererAdd",list_rendererAddHandler);
         addEventListener("rendererRemove",list_rendererRemoveHandler);
         snapToPages = true;
         verticalScrollPolicy = "off";
         horizontalScrollPolicy = "on";
         interactionMode = "mouse";
      }
      
      public function scrollRight() : void
      {
         var _loc1_:Number = horizontalScrollPosition + actualPageWidth;
         scrollToPosition(_loc1_ > maxHorizontalScrollPosition?maxHorizontalScrollPosition:Number(_loc1_),NaN,0.1);
      }
      
      public function scrollLeft() : void
      {
         var _loc1_:Number = horizontalScrollPosition - actualPageWidth;
         scrollToPosition(_loc1_ < minHorizontalScrollPosition?minHorizontalScrollPosition:Number(_loc1_),NaN,0.1);
      }
      
      private function list_rendererAddHandler(param1:Event, param2:TitanPopupMiniHeroListItem) : void
      {
         param2.signal_select.add(handler_itemSelect);
      }
      
      private function handler_itemSelect(param1:TitanPopupMiniHeroListItem) : void
      {
         selectedIndex = param1.index;
      }
      
      private function list_rendererRemoveHandler(param1:Event, param2:TitanPopupMiniHeroListItem) : void
      {
         param2.signal_select.remove(handler_itemSelect);
      }
   }
}
