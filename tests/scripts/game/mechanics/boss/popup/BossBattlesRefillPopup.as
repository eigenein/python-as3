package game.mechanics.boss.popup
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.refillable.RefillableRefillPopupMediatorBase;
   import game.view.popup.refillable.RefillPopupBase;
   import game.view.popup.refillable.RefillPopupClipBase;
   
   public class BossBattlesRefillPopup extends RefillPopupBase
   {
       
      
      public function BossBattlesRefillPopup(param1:RefillableRefillPopupMediatorBase)
      {
         super(param1);
         stashParams.windowName = "arena_battle_refill";
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(RefillPopupClipBase,"popup_refill_arena_battles") as RefillPopupClipBase;
         addChild(clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip.tf_label_buy.text = Translate.translateArgs("UI_POPUP_REFILL_BOSS_TRIES",mediator.refillAmount);
      }
   }
}
