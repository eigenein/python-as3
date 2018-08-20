package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanEditTitlePopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanEditTitlePopup extends ClipBasedPopup
   {
       
      
      private var clip:ClanEditTitlePopupClip;
      
      private var mediator:ClanEditTitlePopupMediator;
      
      public function ClanEditTitlePopup(param1:ClanEditTitlePopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "edit_clan_title";
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanEditTitlePopupClip,"dialog_clan_edit_name");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.button_close.signal_click.add(close);
         clip.button_create.signal_click.add(handler_editTitleClick);
         clip.tf_header.text = Translate.translate("UI_POPUP_CLAN_UPDATE_TITLE_HEADER");
         clip.tf_label_name.text = Translate.translate("UI_POPUP_CLAN_UPDATE_TITLE_CAPTION");
         clip.button_create.label = Translate.translate("UI_POPUP_CLAN_UPDATE_TITLE_OK");
         clip.cost_panel.costData = mediator.cost;
         clip.tf_input_name.addEventListener("change",handler_inputChange);
         clip.tf_input_name.text = mediator.title;
         mediator.isValidInput.onValue(handler_isValidInput);
         mediator.validationResultMessage.onValue(handler_validationResultMessage);
      }
      
      private function handler_isValidInput(param1:Boolean) : void
      {
         clip.button_create.isEnabled = param1;
         clip.button_create.graphics.alpha = !!param1?1:0.5;
      }
      
      private function handler_validationResultMessage(param1:String) : void
      {
         clip.tf_valid_status.text = param1;
      }
      
      private function handler_editTitleClick() : void
      {
         mediator.action_editTitle(clip.tf_input_name.text);
      }
      
      private function handler_inputChange() : void
      {
         var _loc1_:String = clip.tf_input_name.text;
         if(_loc1_.indexOf(" ") == 0)
         {
            _loc1_ = _loc1_.slice(1);
            clip.tf_input_name.text = _loc1_.slice(1);
            return;
         }
         mediator.action_titleInput(_loc1_);
         mediator.action_validate();
      }
   }
}
