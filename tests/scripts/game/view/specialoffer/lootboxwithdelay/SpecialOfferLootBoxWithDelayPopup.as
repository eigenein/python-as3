package game.view.specialoffer.lootboxwithdelay
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.view.popup.AsyncClipBasedPopup;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class SpecialOfferLootBoxWithDelayPopup extends AsyncClipBasedPopup
   {
       
      
      private var mediator:SpecialOfferLootBoxWithDelayPopupMediator;
      
      private var clip:SpecialOfferLootBoxWithDelayPopupClip;
      
      public const signal_chestOpeningAnimationCompleted:Signal = new Signal();
      
      public function SpecialOfferLootBoxWithDelayPopup(param1:SpecialOfferLootBoxWithDelayPopupMediator)
      {
         super(param1,param1.asset.asset as RsxGuiAsset);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(clip)
         {
            if(!clip.animation_closed.graphics.parent)
            {
               clip.animation_closed.dispose();
            }
            if(!clip.animation_opened.graphics.parent)
            {
               clip.animation_opened.dispose();
            }
         }
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = param1.create(SpecialOfferLootBoxWithDelayPopupClip,mediator.asset.clipName);
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_TITLE");
         clip.button_continue.initialize(Translate.translate("UI_SPECIALOFFER_TO_TOWN"),mediator.action_continue);
         clip.button_open.initialize(Translate.translate("UI_POPUP_TOWER_CHEST_OPEN"),handler_buttonOpen);
         clip.button_continue.graphics.visible = clip;
         mediator.timeLeftString.onValue(handler_timeLeftString);
         mediator.isReady.onValue(handler_isReady);
         mediator.isOpen.onValue(handler_isOpen);
         centerPopupBy(clip.graphics);
         updateState();
         clip.animation_opened.hide();
      }
      
      private function updateState() : void
      {
         var _loc1_:Boolean = mediator.isOpen.value;
         var _loc2_:Boolean = mediator.isReady.value;
         clip.tf_timer.visible = !_loc2_;
         var _loc3_:* = !_loc2_;
         clip.button_continue.graphics.visible = _loc3_;
         clip.button_continue.isEnabled = _loc3_;
         _loc3_ = _loc2_ && !_loc1_;
         clip.button_open.graphics.visible = _loc3_;
         clip.button_open.isEnabled = _loc3_;
         clip.line2.graphics.visible = !_loc2_;
         if(_loc2_)
         {
            clip.tf_description.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_DESC_OPEN");
         }
         else
         {
            clip.tf_description.text = Translate.translate("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_DESC");
         }
      }
      
      private function handler_buttonOpen() : void
      {
         mediator.action_open();
         clip.button_open.isEnabled = false;
      }
      
      private function handler_isOpen(param1:Boolean) : void
      {
         if(param1)
         {
            clip.animation_closed.hide();
            clip.animation_opened.show(clip.container);
            clip.animation_opened.playOnce();
            clip.animation_opened.signal_completed.add(mediator.action_chestIsOpen);
         }
         else
         {
            updateState();
         }
      }
      
      private function handler_isReady(param1:Boolean) : void
      {
         updateState();
      }
      
      private function handler_timeLeftString(param1:String) : void
      {
         clip.tf_timer.text = Translate.translateArgs("UI_SPECIALOFFER_LOOTBOX_WITH_DELAY_TIMER_LABEL",ColorUtils.hexToRGBFormat(16777215) + param1);
      }
   }
}
