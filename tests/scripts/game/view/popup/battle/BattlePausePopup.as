package game.view.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.battle.BattlePausePopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class BattlePausePopup extends ClipBasedPopup
   {
       
      
      protected var mediator:BattlePausePopupMediator;
      
      protected var clip:BattlePausePopupClip;
      
      public function BattlePausePopup(param1:BattlePausePopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(mediator)
         {
            mediator.disposeFromPublic();
         }
      }
      
      protected function createClip() : void
      {
         clip = AssetStorage.rsx.battle_interface.create_pausePopup();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         createClip();
         addChild(clip.graphics);
         clip.tf_header.text = Translate.translate("UI_POPUP_BATTLE_PAUSE");
         clip.button_continue.initialize(Translate.translate("UI_POPUP_BATTLE_CONTINUE"),mediator.action_continue);
         clip.button_retreat.initialize(mediator.retreatButtonLabel,mediator.action_retreat);
         clip.button_sound.mediator = mediator.playSounds;
         clip.button_music.mediator = mediator.playMusic;
      }
      
      override public function close() : void
      {
         mediator.close();
      }
   }
}
