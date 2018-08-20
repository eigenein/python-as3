package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import flash.utils.getTimer;
   import game.model.user.ny.NewYearGiftData;
   import game.view.IDisposable;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   import starling.events.Event;
   
   public class NYReceivedGiftsContent extends GuiClipNestedContainer implements IDisposable
   {
       
      
      private var list:GameScrolledList;
      
      private var horizontalPageIndex:uint;
      
      public var tf_title:ClipLabel;
      
      public var tf_list_empty:ClipLabel;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var arrow_left:ClipButton;
      
      public var arrow_right:ClipButton;
      
      private var _mediator:NYGiftsPopupMediator;
      
      public function NYReceivedGiftsContent()
      {
         tf_title = new ClipLabel();
         tf_list_empty = new ClipLabel();
         list_container = new GuiClipLayoutContainer();
         arrow_left = new ClipButton();
         arrow_right = new ClipButton();
         super();
      }
      
      public function dispose() : void
      {
         mediator = null;
      }
      
      public function get mediator() : NYGiftsPopupMediator
      {
         return _mediator;
      }
      
      public function set mediator(param1:NYGiftsPopupMediator) : void
      {
         if(_mediator == param1)
         {
            return;
         }
         if(_mediator)
         {
            _mediator.signal_giftsChange.remove(handler_giftsChange);
         }
         if(param1)
         {
            _mediator = param1;
            _mediator.getGifts(0);
            _mediator.signal_giftsChange.add(handler_giftsChange);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_list_empty.visible = false;
         tf_list_empty.text = Translate.translate("UI_DIALOG_NY_GIFTS_RECEIVED_LIST_EMPTY");
         var _loc2_:* = 50;
         list = new GameScrolledList(null,null,null);
         list.addEventListener("rendererAdd",handler_listRendererAdded);
         list.addEventListener("rendererRemove",handler_listRendererRemoved);
         list.layout = new TiledColumnsLayout();
         (list.layout as TiledColumnsLayout).useSquareTiles = false;
         (list.layout as TiledColumnsLayout).horizontalGap = 10;
         (list.layout as TiledColumnsLayout).paddingTop = _loc2_;
         (list.layout as TiledColumnsLayout).verticalGap = 10;
         (list.layout as TiledColumnsLayout).requestedRowCount = 2;
         (list.layout as TiledColumnsLayout).paging = "horizontal";
         list.y = -_loc2_;
         list.width = list_container.container.width;
         list.height = list_container.container.height + _loc2_;
         list_container.container.addChild(list);
         arrow_left.signal_click.add(scrollLeft);
         arrow_right.signal_click.add(scrollRight);
         arrow_left.graphics.visible = false;
         arrow_right.graphics.visible = false;
      }
      
      private function scrollLeft() : void
      {
         horizontalPageIndex = Number(horizontalPageIndex) - 1;
         list.scrollToPosition(horizontalPageIndex * list.pageWidth,0,0.5);
         updateArrows();
         updateTitle();
      }
      
      private function scrollRight() : void
      {
         horizontalPageIndex = Number(horizontalPageIndex) + 1;
         list.scrollToPosition(horizontalPageIndex * list.pageWidth,0,0.5);
         updateArrows();
         updateTitle();
      }
      
      private function updateArrows() : void
      {
         var _loc1_:Number = list.maxHorizontalScrollPosition - list.minHorizontalScrollPosition;
         var _loc2_:int = Math.ceil(_loc1_ / list.pageWidth) + 1;
         arrow_left.graphics.visible = horizontalPageIndex != 0;
         arrow_right.graphics.visible = horizontalPageIndex + 1 != _loc2_;
      }
      
      private function updateTitle() : void
      {
         var _loc1_:uint = 4;
         if(mediator.gifts.length > _loc1_)
         {
            tf_title.text = Translate.translateArgs("UI_DIALOG_NY_GIFTS_RECEIVED",horizontalPageIndex * _loc1_ + 1 + " - " + Math.min(horizontalPageIndex * _loc1_ + _loc1_,mediator.gifts.length) + " / " + mediator.gifts.length);
         }
         else
         {
            tf_title.text = Translate.translateArgs("UI_DIALOG_NY_GIFTS_RECEIVED",mediator.gifts.length);
         }
      }
      
      private function handler_listRendererAdded(param1:Event, param2:NYReceivedGiftRenderer) : void
      {
         param2.signal_giftOpen.add(handler_giftOpen);
         param2.signal_send.add(handler_send);
      }
      
      private function handler_listRendererRemoved(param1:Event, param2:NYReceivedGiftRenderer) : void
      {
         param2.signal_giftOpen.remove(handler_giftOpen);
         param2.signal_send.remove(handler_send);
      }
      
      private function handler_giftOpen(param1:NewYearGiftData) : void
      {
         mediator.action_giftOpen(param1);
      }
      
      private function handler_send(param1:NewYearGiftData) : void
      {
         mediator.action_giftSend(param1);
      }
      
      private function handler_giftsChange() : void
      {
         var _loc1_:int = getTimer();
         list.itemRendererType = !!mediator.hasNewYearOffer()?NYReceivedGiftRenderer:NYReceivedGiftWithoutReplyRenderer;
         list.dataProvider = new ListCollection(mediator.gifts);
         list.visible = list.dataProvider.length > 0;
         horizontalPageIndex = 0;
         trace("handler_giftsChange",getTimer() - _loc1_);
         list.validate();
         tf_list_empty.visible = !list.visible;
         trace("handler_giftsChange",getTimer() - _loc1_);
         updateArrows();
         updateTitle();
      }
   }
}
