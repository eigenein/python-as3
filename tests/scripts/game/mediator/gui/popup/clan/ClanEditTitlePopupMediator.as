package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.command.rpc.clan.CommandClanUpdateTitle;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.util.FoulLanguageFilter;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanEditTitlePopup;
   
   public class ClanEditTitlePopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var titleValidator:ClanTitleValidator;
      
      private const _isValidInput:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _validationResultMessage:StringPropertyWriteable = new StringPropertyWriteable();
      
      public const isValidInput:BooleanProperty = _isValidInput;
      
      public const validationResultMessage:StringProperty = _validationResultMessage;
      
      private var _cost:InventoryItem;
      
      private var _title:String;
      
      public function ClanEditTitlePopupMediator(param1:Player)
      {
         super(param1);
         _cost = DataStorage.rule.clanRule.changeTitleCost.outputDisplay[0];
         _title = param1.clan.clan.title;
         titleValidator = new ClanTitleValidator(_title);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get cost() : InventoryItem
      {
         return _cost;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEditTitlePopup(this);
         return _popup;
      }
      
      public function action_validate() : void
      {
         titleValidator.validate(_title);
         _validationResultMessage.value = titleValidator.message;
         _isValidInput.value = titleValidator.isValid;
      }
      
      public function action_editTitle(param1:String) : void
      {
         var _loc2_:* = null;
         if(FoulLanguageFilter.containBadWords(param1))
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_CLAN_UPDATE_TITLE_FOUL_LANGUAGE"));
         }
         else
         {
            _loc2_ = GameModel.instance.actionManager.clan.clanUpdateTitle(param1);
            _loc2_.onClientExecute(handler_complete);
         }
      }
      
      public function action_titleInput(param1:String) : void
      {
         _title = param1;
      }
      
      private function handler_complete(param1:CommandClanUpdateTitle) : void
      {
         if(param1.error_titleNotUnique)
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_CLAN_EDIT_TITLE_ERR_MSG"));
         }
         else
         {
            close();
         }
      }
   }
}
