package game.view.popup.shop.titansoul
{
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.shop.ShopSlotValueObject;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopPopupMediator;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.common.PopupTitle;
   import game.view.popup.shop.ShopPopup;
   import game.view.popup.shop.ShopPopupItemRenderer;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class TitanSoulShopPopup extends ClipBasedPopup implements ITutorialNodePresenter
   {
       
      
      private var mediator:TitanSoulShopPopupMediator;
      
      private var clip:TitanSoulShopPopupClip;
      
      public function TitanSoulShopPopup(param1:TitanSoulShopPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "store_titansoul";
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TITAN_SOUL_SHOP;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         ShopPopup.music.shopOpen();
         clip = AssetStorage.rsx.popup_theme.create(TitanSoulShopPopupClip,"dialog_shop_titan_soul");
         addChild(clip.graphics);
         centerPopupBy(clip.dialog_frame.graphics,0,25);
         clip.list.itemRendererType = ShopPopupItemRenderer;
         clip.list.addEventListener("rendererAdd",onListRendererAdded);
         clip.list.addEventListener("rendererRemove",onListRendererRemoved);
         var _loc2_:TiledRowsLayout = new TiledRowsLayout();
         _loc2_.useSquareTiles = false;
         _loc2_.gap = 5;
         _loc2_.paddingTop = 20;
         _loc2_.paddingBottom = 10;
         clip.list.layout = _loc2_;
         clip.list.interactionMode = "mouse";
         clip.list.scrollBarDisplayMode = "fixed";
         clip.list.horizontalScrollPolicy = "off";
         clip.list.verticalScrollPolicy = "on";
         clip.list.dataProvider = mediator.itemList;
         PopupTitle.create(mediator.name,clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.gap = -12;
         mediator.dataIsUpToDate.onValue(handler_dataIsUpToDate);
         Starling.juggler.delayCall(mediator.action_popupIsOpen,0);
      }
      
      private function onListRendererAdded(param1:Event, param2:ShopPopupItemRenderer) : void
      {
         param2.signal_buySlot.add(onBuySignal);
         param2.signal_showInfo.add(onShowInfoSignal);
      }
      
      private function onListRendererRemoved(param1:Event, param2:ShopPopupItemRenderer) : void
      {
         param2.signal_buySlot.remove(onBuySignal);
         param2.signal_showInfo.remove(onShowInfoSignal);
      }
      
      private function onShowInfoSignal(param1:ShopSlotValueObject) : void
      {
         mediator.action_showInfo(param1);
      }
      
      private function onBuySignal(param1:ShopSlotValueObject) : void
      {
         mediator.action_buySlot(param1);
      }
      
      private function handler_dataIsUpToDate(param1:Boolean) : void
      {
         clip.list.touchable = param1;
      }
   }
}
