package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.command.rpc.clan.CommandClanCreate;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.util.FoulLanguageFilter;
   import game.view.popup.PopupBase;
   import game.view.popup.clan.ClanCreatePopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanCreatePopupMediator extends PopupMediator
   {
       
      
      private var _icon:ClanIconValueObject;
      
      private var _minLevelCapFrom:int;
      
      private var _minLevelCapTo:int;
      
      private var _minLevelCapStep:int = 10;
      
      private const titleValidator:ClanTitleValidator = new ClanTitleValidator();
      
      private const _isValidInput:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _validationResultMessage:StringPropertyWriteable = new StringPropertyWriteable();
      
      public const signal_iconUpdated:Signal = new Signal();
      
      public const isValidInput:BooleanProperty = _isValidInput;
      
      public const validationResultMessage:StringProperty = _validationResultMessage;
      
      private var _clanCreationCost:InventoryItem;
      
      private var _minLevel:int;
      
      private var _signal_minLevelUpdate:Signal;
      
      public function ClanCreatePopupMediator(param1:Player)
      {
         _icon = ClanIconValueObject.random();
         _signal_minLevelUpdate = new Signal();
         super(param1);
         _clanCreationCost = DataStorage.level.getClanLevel(1).levelUpCost.outputDisplay[0];
         _minLevel = MechanicStorage.CLAN.teamLevel;
         _minLevelCapFrom = MechanicStorage.CLAN.teamLevel;
         _minLevelCapTo = int(DataStorage.level.getMaxTeamLevel() / 10) * 10;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney();
         return _loc1_;
      }
      
      public function get clanCreationCost() : InventoryItem
      {
         return _clanCreationCost;
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get signal_minLevelUpdate() : Signal
      {
         return _signal_minLevelUpdate;
      }
      
      public function get minLevelCanDecrease() : Boolean
      {
         return _minLevel > _minLevelCapFrom;
      }
      
      public function get minLevelCanIncrease() : Boolean
      {
         return _minLevel < _minLevelCapTo;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return _icon;
      }
      
      public function action_create(param1:String, param2:String) : void
      {
         var _loc3_:* = null;
         if(FoulLanguageFilter.containBadWords(param1))
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_CLAN_UPDATE_TITLE_FOUL_LANGUAGE"));
         }
         else
         {
            _loc3_ = GameModel.instance.actionManager.clan.clanCreate(param1,param2,minLevel,icon);
            _loc3_.onClientExecute(handler_commandClanCreate);
         }
      }
      
      public function action_checkName(param1:String) : void
      {
         GameModel.instance.actionManager.clan.clanIsTitleUnique(param1);
      }
      
      public function action_checkInput(param1:String) : void
      {
         titleValidator.validate(param1);
         _isValidInput.value = titleValidator.isValid;
         _validationResultMessage.value = titleValidator.message;
      }
      
      public function action_editBanner() : void
      {
         var _loc1_:ClanEditIconPopupMediator = new ClanEditIconPopupMediator(player,_icon,false);
         _loc1_.open(Stash.click("edit_caln_icon",_popup.stashParams));
         _loc1_.signal_complete.addOnce(handler_iconUpdated);
      }
      
      public function action_levelMinus() : void
      {
         var _loc1_:int = _minLevel;
         if(_minLevel > _minLevelCapFrom)
         {
            _minLevel = _minLevel - _minLevelCapStep;
         }
         if(_minLevel < _minLevelCapFrom)
         {
            _minLevel = _minLevelCapFrom;
         }
         if(_minLevel != _loc1_)
         {
            _signal_minLevelUpdate.dispatch();
         }
      }
      
      public function action_levelPlus() : void
      {
         var _loc1_:int = _minLevel;
         if(_minLevel < _minLevelCapTo)
         {
            _minLevel = _minLevel + _minLevelCapStep;
         }
         if(_minLevel > _minLevelCapTo)
         {
            _minLevel = _minLevelCapTo;
         }
         if(_minLevel != _loc1_)
         {
            _signal_minLevelUpdate.dispatch();
         }
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanCreatePopup(this);
         return _popup;
      }
      
      private function handler_iconUpdated(param1:ClanIconValueObject) : void
      {
         _icon = param1;
         signal_iconUpdated.dispatch();
      }
      
      private function handler_commandClanCreate(param1:CommandClanCreate) : void
      {
         if(param1.error_titleNotUnique)
         {
            PopupList.instance.message(Translate.translate("UI_POPUP_CLAN_EDIT_TITLE_ERR_MSG"));
         }
         else
         {
            Game.instance.navigator.navigateToClan(Stash.click("clan_info",_popup.stashParams));
            close();
            GamePopupManager.closeAll();
         }
      }
   }
}
