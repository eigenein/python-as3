package game.view.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.player.PlayerNicknameChangePopupMediator;
   import game.view.popup.ClipBasedPopup;
   import starling.events.Event;
   
   public class PlayerNicknameChangePopup extends ClipBasedPopup
   {
       
      
      private var mediator:PlayerNicknameChangePopupMediator;
      
      private var clip:PlayerNicknameChangePopupClip;
      
      public function PlayerNicknameChangePopup(param1:PlayerNicknameChangePopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_popup_player_nickname_change();
         addChild(clip.graphics);
         clip.tf_caption.text = Translate.translate("UI_DIALOG_NAME_CHANGE_TITLE");
         clip.btn_change.label = Translate.translate("UI_DIALOG_NAME_CHANGE_ACCEPT");
         clip.btn_random.label = Translate.translate("UI_DIALOG_NAME_CHANGE_RANDOM");
         clip.button_close.signal_click.add(mediator.close);
         clip.btn_change.signal_click.add(handler_changeName);
         clip.btn_random.signal_click.add(handler_randomName);
         clip.tf_name_input.text = mediator.nickname;
         clip.tf_name_input.addEventListener("change",handler_input);
         if(mediator.cost)
         {
            clip.cost.costData = mediator.cost;
         }
         else
         {
            clip.cost.graphics.visible = false;
         }
         mediator.signal_changeAvailable.add(handler_changeAvailable);
         handler_changeAvailable();
      }
      
      private function handler_input(param1:Event) : void
      {
         var _loc2_:String = clip.tf_name_input.text;
         if(_loc2_.indexOf(" ") == 0)
         {
            _loc2_ = _loc2_.slice(1);
            clip.tf_name_input.text = _loc2_.slice(1);
            return;
         }
         mediator.action_checkInput(clip.tf_name_input.text);
      }
      
      private function handler_randomName() : void
      {
         clip.tf_name_input.text = mediator.action_generate();
      }
      
      private function handler_changeName() : void
      {
         mediator.action_changeNickname(clip.tf_name_input.text);
      }
      
      private function handler_changeAvailable() : void
      {
         clip.btn_change.isEnabled = mediator.isValidInput;
         clip.btn_change.graphics.alpha = !!clip.btn_change.isEnabled?1:0.5;
         clip.tf_validation_notice.text = mediator.validateResultMessage;
      }
   }
}
