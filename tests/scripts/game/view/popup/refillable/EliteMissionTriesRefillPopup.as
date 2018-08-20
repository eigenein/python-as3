package game.view.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.refillable.EliteMissionTriesRefillPopupMediator;
   
   public class EliteMissionTriesRefillPopup extends RefillPopupBase
   {
       
      
      public function EliteMissionTriesRefillPopup(param1:EliteMissionTriesRefillPopupMediator)
      {
         super(param1);
         stashParams.windowName = "elite_tries_refill";
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(RefillPopupClipBase,"popup_refill_arena_battles") as RefillPopupClipBase;
         addChild(clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip.tf_label_buy.text = Translate.translateArgs("UI_POPUP_REFILL_MISSION_TRIES",mediator.refillAmount);
      }
   }
}
