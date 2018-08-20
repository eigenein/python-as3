package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.nygifts.NYGiftDescription;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.controller.TouchClickController;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.popup.refillable.CostButton;
   
   public class NYGiftItemRenderer extends GuiClipNestedContainer
   {
       
      
      private var gift:NYGiftDescription;
      
      private var giftAnimationView:NYGiftAnimationView;
      
      private var buttonHoverController:TouchHoverContoller;
      
      private var animationClickController:TouchClickController;
      
      public var tf_title:ClipLabel;
      
      public var tf_send:ClipLabel;
      
      public var gift_container:GuiClipLayoutContainer;
      
      public var btn_info:ClipButton;
      
      public var btn_send:CostButton;
      
      public var mediator:NYGiftsPopupMediator;
      
      public function NYGiftItemRenderer()
      {
         tf_title = new ClipLabel();
         tf_send = new ClipLabel();
         gift_container = new GuiClipLayoutContainer();
         btn_info = new ClipButton();
         btn_send = new CostButton();
         super();
      }
      
      public function dispose() : void
      {
         if(buttonHoverController)
         {
            buttonHoverController.dispose();
         }
         if(animationClickController)
         {
            animationClickController.dispose();
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         btn_send.signal_click.add(handler_btn_send_click);
         btn_info.signal_click.add(handler_btn_info_click);
         buttonHoverController = new TouchHoverContoller(btn_send.container);
         buttonHoverController.signal_hoverChanger.add(handler_buttonHover);
      }
      
      public function setData(param1:NYGiftDescription) : void
      {
         gift = param1;
         tf_title.text = param1.name;
         tf_send.text = Translate.translate("UI_DIALOG_NY_GIFTS_SEND");
         btn_send.cost = param1.cost.outputDisplayFirst;
         gift_container.container.removeChildren();
         giftAnimationView = AssetStorage.rsx.ny_gifts.create(NYGiftAnimationView,param1.asset);
         gift_container.container.addChild(giftAnimationView.graphics);
         if(animationClickController)
         {
            animationClickController.dispose();
         }
         animationClickController = new TouchClickController(giftAnimationView.container);
         animationClickController.onClick.add(handler_animationClick);
      }
      
      private function handler_btn_send_click() : void
      {
         mediator.action_showSelectFriendToSendGift(gift);
      }
      
      private function handler_btn_info_click() : void
      {
         mediator.action_showNYGiftInfo(gift);
      }
      
      private function handler_buttonHover() : void
      {
         if(buttonHoverController.hover)
         {
            giftAnimationView.playHoverAnimation();
         }
      }
      
      private function handler_animationClick() : void
      {
         mediator.action_showSelectFriendToSendGift(gift);
      }
   }
}
