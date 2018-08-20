package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanCreatePopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.clan.editicon.ClanIconClip;
   import starling.events.Event;
   
   public class ClanCreatePopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanCreatePopupMediator;
      
      private var banner:ClanIconClip;
      
      private var clip:ClanCreatePopupClip;
      
      public function ClanCreatePopup(param1:ClanCreatePopupMediator)
      {
         super(param1);
         mediator = param1;
      }
      
      override public function close() : void
      {
         mediator.signal_minLevelUpdate.remove(handler_minLevelUpdate);
         super.close();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanCreatePopupClip,"dialog_clan_create");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_CLAN_CREATE");
         clip.button_create.initialize(Translate.translate("UI_DIALOG_CLAN_CREATE_BUTTON"),handler_buttonSubmit);
         clip.button_banner_change.initialize(Translate.translate("UI_DIALOG_CLAN_CREATE_EDIT_BANNER"),mediator.action_editBanner);
         clip.tf_label_banner.text = Translate.translate("UI_DIALOG_CLAN_CREATE_BANNER");
         clip.tf_label_name.text = Translate.translate("UI_DIALOG_CLAN_NAME");
         clip.tf_label_max_level.text = Translate.translate("UI_DIALOG_CLAN_CREATE_MINLVL");
         banner = AssetStorage.rsx.clan_icons.createFlagClip();
         clip.layout_banner.addChild(banner.graphics);
         handler_iconUpdated();
         mediator.signal_iconUpdated.add(handler_iconUpdated);
         clip.cost_panel.costData = mediator.clanCreationCost;
         clip.button_close.signal_click.add(close);
         clip.level_minus.signal_click.add(mediator.action_levelMinus);
         clip.level_plus.signal_click.add(mediator.action_levelPlus);
         mediator.signal_minLevelUpdate.add(handler_minLevelUpdate);
         mediator.isValidInput.onValue(handler_isValidInput);
         mediator.validationResultMessage.onValue(handler_validationResultMessage);
         updateTeamLevel();
         clip.tf_input_name.prompt = Translate.translate("UI_DIALOG_CLAN_CREATE_PROMPT");
         clip.tf_input_name.addEventListener("change",handler_input);
      }
      
      private function updateTeamLevel() : void
      {
         clip.level_minus.isEnabled = mediator.minLevelCanDecrease;
         clip.level_minus.graphics.alpha = !!clip.level_minus.isEnabled?1:0.5;
         clip.level_plus.isEnabled = mediator.minLevelCanIncrease;
         clip.level_plus.graphics.alpha = !!clip.level_plus.isEnabled?1:0.5;
         clip.tf_min_level.text = mediator.minLevel.toString();
      }
      
      private function handler_buttonCheck() : void
      {
         mediator.action_checkName(clip.tf_input_name.text);
      }
      
      private function handler_buttonSubmit() : void
      {
         mediator.action_create(clip.tf_input_name.text,"");
      }
      
      private function handler_minLevelUpdate() : void
      {
         updateTeamLevel();
      }
      
      private function handler_iconUpdated() : void
      {
         AssetStorage.rsx.clan_icons.setupFlag(banner,mediator.icon);
      }
      
      private function handler_input(param1:Event) : void
      {
         var _loc2_:String = clip.tf_input_name.text;
         if(_loc2_.indexOf(" ") == 0)
         {
            _loc2_ = _loc2_.slice(1);
            clip.tf_input_name.text = _loc2_.slice(1);
            return;
         }
         mediator.action_checkInput(_loc2_);
      }
      
      private function handler_isValidInput(param1:Boolean) : void
      {
         clip.button_create.isEnabled = param1;
         clip.button_create.graphics.alpha = 0.5 + int(param1) * 0.5;
      }
      
      private function handler_validationResultMessage(param1:String) : void
      {
         clip.tf_valid_status.text = param1;
      }
   }
}
