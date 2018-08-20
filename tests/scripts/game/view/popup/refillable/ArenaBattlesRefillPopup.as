package game.view.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.refillable.RefillableRefillPopupMediatorBase;
   
   public class ArenaBattlesRefillPopup extends RefillPopupBase
   {
       
      
      public function ArenaBattlesRefillPopup(param1:RefillableRefillPopupMediatorBase)
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
         clip.tf_label_buy.text = Translate.translateArgs("UI_POPUP_REFILL_ARENA_BATTLES",mediator.refillAmount);
      }
   }
}
