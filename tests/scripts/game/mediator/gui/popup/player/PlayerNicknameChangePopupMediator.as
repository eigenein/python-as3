package game.mediator.gui.popup.player
{
   import com.progrestar.common.lang.Translate;
   import game.data.cost.CostData;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.refillable.PlayerRefillableEntry;
   import game.util.FoulLanguageFilter;
   import game.view.popup.PopupBase;
   import game.view.popup.player.PlayerNicknameChangePopup;
   import idv.cjcat.signals.Signal;
   
   public class PlayerNicknameChangePopupMediator extends PopupMediator
   {
       
      
      private var _maxLength:int;
      
      private var _minLength:int;
      
      private var _regexp:RegExp;
      
      private var _isValidInput:Boolean;
      
      private var _validateResultMessage:String;
      
      private var _signal_changeAvailable:Signal;
      
      private var _cost:CostData;
      
      public function PlayerNicknameChangePopupMediator(param1:Player)
      {
         _signal_changeAvailable = new Signal();
         super(param1);
         if(param1.flags.getFlag(4))
         {
            _cost = new CostData(DataStorage.rule.nicknameUpdate.cost);
         }
         _maxLength = DataStorage.rule.nicknameUpdate.maxLength;
         _minLength = DataStorage.rule.nicknameUpdate.minLength;
         var _loc2_:String = DataStorage.rule.nicknameUpdate.regexp;
         var _loc3_:String = _loc2_.slice(1,_loc2_.lastIndexOf("/"));
         var _loc4_:String = _loc2_.slice(_loc2_.lastIndexOf("/") + 1);
         _regexp = new RegExp(_loc3_,_loc4_);
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         _loc1_.requre_starmoney(true);
         return _loc1_;
      }
      
      public function get isValidInput() : Boolean
      {
         return _isValidInput;
      }
      
      protected function setIsValidInput(param1:Boolean) : void
      {
         _isValidInput = param1;
         _signal_changeAvailable.dispatch();
      }
      
      public function get validateResultMessage() : String
      {
         return _validateResultMessage;
      }
      
      public function get signal_changeAvailable() : Signal
      {
         return _signal_changeAvailable;
      }
      
      public function get nickname() : String
      {
         return player.nickname;
      }
      
      public function get cooldown() : int
      {
         var _loc1_:PlayerRefillableEntry = player.refillable.getById(DataStorage.rule.nicknameUpdate.cooldown);
         return 0;
      }
      
      public function get cost() : InventoryItem
      {
         return !!_cost?_cost.outputDisplay[0]:null;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new PlayerNicknameChangePopup(this);
         return _popup;
      }
      
      public function action_changeNickname(param1:String) : void
      {
         if(FoulLanguageFilter.containBadWords(param1))
         {
            PopupList.instance.message(Translate.translate("UI_DIALOG_NAME_CHANGE_FOUL_LANGUAGE"));
         }
         else
         {
            GameModel.instance.actionManager.playerCommands.changeNickname(param1);
            close();
         }
      }
      
      public function action_generate() : String
      {
         return DataStorage.nickname.getRandomNickname();
      }
      
      public function action_checkInput(param1:String) : void
      {
         var _loc2_:Boolean = true;
         _validateResultMessage = "";
         if(param1 == player.nickname)
         {
            _loc2_ = false;
         }
         if(param1.length < _minLength)
         {
            _validateResultMessage = Translate.translate("UI_DIALOG_NAME_CHANGE_TOO_SHORT");
            _loc2_ = false;
         }
         if(param1.length > _maxLength)
         {
            _validateResultMessage = Translate.translate("UI_DIALOG_NAME_CHANGE_TOO_LONG");
            _loc2_ = false;
         }
         var _loc3_:Array = param1.toLowerCase().match(_regexp);
         if(_loc3_ && _loc3_.length > 0)
         {
            _validateResultMessage = Translate.translate("UI_DIALOG_NAME_CHANGE_INVALID_CHARECTERS");
            _loc2_ = false;
         }
         setIsValidInput(_loc2_);
      }
   }
}
