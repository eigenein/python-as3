package game.view.popup.socialgrouppromotion
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionMediator;
   import game.view.popup.common.IPopupSideBarBlock;
   import game.view.popup.common.PopupSideBarSide;
   import starling.display.DisplayObject;
   
   public class SocialGroupPromotionBlock implements IPopupSideBarBlock
   {
       
      
      private var clip:SocialGroupPromotionBlockClip;
      
      private var mediator:SocialGroupPromotionMediator;
      
      private var stashParams:PopupStashEventParams;
      
      public function SocialGroupPromotionBlock(param1:SocialGroupPromotionMediator)
      {
         super();
         this.mediator = param1;
         clip = new SocialGroupPromotionBlockClip();
         AssetStorage.rsx.popup_theme.initGuiClip(clip,"social_group_promotion_block");
         clip.image_icon.image.texture = AssetStorage.rsx.popup_theme.getTexture(param1.iconTexture);
         clip.text_underlined.label = param1.messageText;
         clip.tf_hover_text.text = param1.hoverText;
         clip.signal_click.add(handler_click);
         if(clip.button_close)
         {
            if(!param1.closeable)
            {
               clip.button_close.graphics.removeFromParent();
            }
            clip.button_close.signal_click.add(handler_close);
         }
         clip.resize();
      }
      
      public function dispose() : void
      {
         if(clip)
         {
            clip.signal_click.remove(handler_click);
            if(clip.button_close)
            {
               clip.button_close.signal_click.remove(handler_close);
            }
         }
      }
      
      public function get graphics() : DisplayObject
      {
         return clip.graphics;
      }
      
      public function get popupOffset() : Number
      {
         return 0;
      }
      
      public function get popupGap() : Number
      {
         return 5;
      }
      
      public function get popupSide() : PopupSideBarSide
      {
         return PopupSideBarSide.bottom;
      }
      
      public function initialize(param1:PopupStashEventParams) : void
      {
         this.stashParams = param1;
      }
      
      private function handler_click() : void
      {
         mediator.action_select(stashParams);
      }
      
      private function handler_close() : void
      {
         mediator.action_close();
         clip.graphics.visible = false;
         dispose();
      }
   }
}
