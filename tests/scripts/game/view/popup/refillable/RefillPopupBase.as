package game.view.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.refillable.RefillableRefillPopupMediatorBase;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.ClipBasedPopup;
   
   public class RefillPopupBase extends ClipBasedPopup implements ITutorialActionProvider
   {
       
      
      protected var clip:RefillPopupClipBase;
      
      protected var mediator:RefillableRefillPopupMediatorBase;
      
      public function RefillPopupBase(param1:RefillableRefillPopupMediatorBase)
      {
         super(param1);
         this.mediator = param1;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(clip.button_buy);
         return _loc2_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createClip();
         clip.refill_block.button_ok.label = Translate.translate("U_POPUP_STAMINA_REFILL_BANK");
         clip.refill_block.button_ok.signal_click.add(mediator.action_increaseVIP);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_buy.signal_click.add(mediator.action_buy);
         clip.tf_label_tries.text = Translate.translate("U_POPUP_STAMINA_REFILL_AVAILABLE");
         commitData();
      }
      
      protected function commitData() : void
      {
         clip.button_buy.cost = mediator.refillCost;
         var _loc2_:* = mediator.maxRefillCount >= 0;
         var _loc1_:Boolean = mediator.refillCount <= 0 && _loc2_;
         clip.refill_block.graphics.visible = _loc1_;
         if(_loc1_)
         {
            clip.button_buy.graphics.visible = false;
            clip.refill_block.next_vip_level.setVip(mediator.nextVipLevel);
            clip.refill_block.tf_message.text = Translate.translateArgs("U_POPUP_STAMINA_REFILL_PLUS_COUNT",mediator.nextVipAdditionalAttempts);
            clip.bg.graphics.height = clip.refill_block.graphics.y + clip.refill_block.graphics.height + 20;
         }
         clip.tf_tries.text = mediator.refillCount + "/" + mediator.maxRefillCount;
         clip.layout_tries.visible = _loc2_;
         clip.button_buy.graphics.y = !!_loc2_?110:85;
         if(!_loc2_)
         {
            clip.bg.graphics.height = clip.button_buy.graphics.y + clip.button_buy.graphics.height + 22;
         }
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(RefillPopupClipBase,"popup_refill_arena_battles") as RefillPopupClipBase;
         addChild(clip.graphics);
      }
   }
}
