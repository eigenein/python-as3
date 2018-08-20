package game.view.specialoffer.multibundle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class CyberMondayTripleSkinCoinPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:CyberMondayTripleSkinCoinPopupMediator;
      
      private var clip:CyberMondayTripleSkinCoinPopupClip;
      
      public function CyberMondayTripleSkinCoinPopup(param1:CyberMondayTripleSkinCoinPopupMediator)
      {
         super(param1,param1.asset.asset as RsxGuiAsset);
         this.mediator = param1;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         var _loc2_:int = 0;
         clip = param1.create(CyberMondayTripleSkinCoinPopupClip,"dialog_bundle_skin_coins");
         addChild(clip.graphics);
         centerPopupBy(clip.graphics);
         var _loc3_:int = clip.renderer.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(mediator.billingList.length > _loc2_)
            {
               clip.renderer[_loc2_].setData(mediator.billingList[_loc2_],mediator);
            }
            _loc2_++;
         }
         clip.tf_label_timer.text = Translate.translate("UI_POPUP_BUNDLE_TIMER");
         clip.tf_header.text = mediator.headerText;
         mediator.signal_updateTime.add(handler_updateTimer);
         handler_updateTimer();
         clip.button_close.signal_click.add(mediator.close);
         width = 1000;
         height = 640;
      }
      
      protected function handler_updateTimer() : void
      {
         if(clip && mediator)
         {
            clip.tf_timer.text = mediator.timeLeftString;
         }
      }
   }
}
