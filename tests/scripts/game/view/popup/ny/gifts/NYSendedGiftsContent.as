package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import game.view.IDisposable;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYSendedGiftsContent extends GuiClipNestedContainer implements IDisposable
   {
       
      
      private var list:GameScrolledList;
      
      private var horizontalPageIndex:uint;
      
      public var tf_title:ClipLabel;
      
      public var tf_list_empty:ClipLabel;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var arrow_left:ClipButton;
      
      public var arrow_right:ClipButton;
      
      private var _mediator:NYGiftsPopupMediator;
      
      public function NYSendedGiftsContent()
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
            _mediator.getGifts(1);
            _mediator.signal_giftsChange.add(handler_giftsChange);
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_list_empty.visible = false;
         tf_list_empty.text = Translate.translate("UI_DIALOG_NY_GIFTS_SENDED_LIST_EMPTY");
         var _loc2_:* = 50;
         list = new GameScrolledList(null,null,null);
         list.itemRendererType = NYSendedGiftRenderer;
         list.layout = new TiledColumnsLayout();
         (list.layout as TiledColumnsLayout).useSquareTiles = false;
         (list.layout as TiledColumnsLayout).horizontalGap = -2;
         (list.layout as TiledColumnsLayout).paddingTop = _loc2_;
         (list.layout as TiledColumnsLayout).verticalGap = 0;
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
      }
      
      private function scrollRight() : void
      {
         horizontalPageIndex = Number(horizontalPageIndex) + 1;
         list.scrollToPosition(horizontalPageIndex * list.pageWidth,0,0.5);
         updateArrows();
      }
      
      private function updateArrows() : void
      {
         var _loc1_:Number = list.maxHorizontalScrollPosition - list.minHorizontalScrollPosition;
         var _loc2_:int = Math.ceil(_loc1_ / list.pageWidth) + 1;
         arrow_left.graphics.visible = horizontalPageIndex != 0;
         arrow_right.graphics.visible = horizontalPageIndex + 1 != _loc2_;
      }
      
      private function handler_giftsChange() : void
      {
         tf_title.text = Translate.translateArgs("UI_DIALOG_NY_GIFTS_SENDED",mediator.gifts.length);
         list.dataProvider = new ListCollection(mediator.gifts);
         list.visible = list.dataProvider.length > 0;
         horizontalPageIndex = 0;
         list.validate();
         tf_list_empty.visible = !list.visible;
         updateArrows();
      }
   }
}
