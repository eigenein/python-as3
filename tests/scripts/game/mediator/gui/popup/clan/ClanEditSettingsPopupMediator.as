package game.mediator.gui.popup.clan
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.command.rpc.clan.CommandClanUpdate;
   import game.command.rpc.clan.CommandClanUpdateIcon;
   import game.command.rpc.clan.value.ClanIconValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.blasklist.ClanBlackListPopUpMediator;
   import game.view.popup.clan.ClanEditRolesPopupMediator;
   import game.view.popup.clan.ClanEditSettingsPopup;
   import idv.cjcat.signals.Signal;
   
   public class ClanEditSettingsPopupMediator extends ClanPopupMediatorBase
   {
       
      
      private const _levelWasChanged:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private const _levelIsUpdating:BooleanPropertyWriteable = new BooleanPropertyWriteable(false);
      
      private var _clan:ClanPrivateInfoValueObject;
      
      private var _playerRank:ClanRole;
      
      public const levelWasChanged:BooleanProperty = _levelWasChanged;
      
      public const levelIsUpdating:BooleanProperty = _levelIsUpdating;
      
      private var _minLevel:int;
      
      private var _maxLevel:int;
      
      private var _step:int;
      
      private var _signal_roleUpdated:Signal;
      
      public function ClanEditSettingsPopupMediator(param1:Player)
      {
         _signal_roleUpdated = new Signal();
         super(param1);
         _clan = param1.clan.clan;
         _playerRank = param1.clan.playerRole;
         _step = 10;
         _minLevel = MechanicStorage.CLAN.teamLevel;
         _minLevel = MechanicStorage.CLAN.teamLevel;
         _maxLevel = int(DataStorage.level.getMaxTeamLevel() / 10) * 10;
         param1.clan.signal_roleUpdate.add(handler_roleUpdate);
      }
      
      override protected function dispose() : void
      {
         player.clan.signal_roleUpdate.remove(handler_roleUpdate);
      }
      
      public function get minLevel() : int
      {
         return _minLevel;
      }
      
      public function get maxLevel() : int
      {
         return _maxLevel;
      }
      
      public function get step() : int
      {
         return _step;
      }
      
      public function get value() : int
      {
         return player.clan.clan.minLevel;
      }
      
      public function get icon() : ClanIconValueObject
      {
         return _clan.icon;
      }
      
      public function get hasPermission_edit_banner() : Boolean
      {
         return _playerRank.permission_edit_banner;
      }
      
      public function get hasPermission_edit_title() : Boolean
      {
         return _playerRank.permission_edit_title;
      }
      
      public function get signal_roleUpdated() : Signal
      {
         return _signal_roleUpdated;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new ClanEditSettingsPopup(this);
         return _popup;
      }
      
      public function action_updateLevel(param1:int) : void
      {
         _levelIsUpdating.value = true;
         var _loc2_:CommandClanUpdate = GameModel.instance.actionManager.clan.clanUpdate(null,null,null,param1);
         _loc2_.onClientExecute(handler_updateLevel);
      }
      
      public function action_levelChanged(param1:int) : void
      {
         _levelWasChanged.value = param1 != player.clan.clan.minLevel;
      }
      
      public function action_editBanner() : void
      {
         var _loc1_:ClanEditIconPopupMediator = new ClanEditIconPopupMediator(player,_clan.icon,true);
         _loc1_.open(Stash.click("edit_clan_icon",_popup.stashParams));
         _loc1_.signal_complete.addOnce(handler_iconSet);
      }
      
      public function action_edit_roles() : void
      {
         var _loc1_:ClanEditRolesPopupMediator = new ClanEditRolesPopupMediator(player);
         _loc1_.open(Stash.click("edit_clan_roles",_popup.stashParams));
      }
      
      public function action_edit_title() : void
      {
         var _loc1_:ClanEditTitlePopupMediator = new ClanEditTitlePopupMediator(player);
         _loc1_.open(Stash.click("edit_clan_title",_popup.stashParams));
      }
      
      public function action_showBlackList() : void
      {
         var _loc1_:ClanBlackListPopUpMediator = new ClanBlackListPopUpMediator(player);
         _loc1_.open(_popup.stashParams);
      }
      
      private function handler_iconSet(param1:ClanIconValueObject) : void
      {
         var _loc2_:ClanIconValueObject = icon;
         if(_loc2_.flagColor1 == param1.flagColor1 && _loc2_.flagColor2 == param1.flagColor2 && _loc2_.flagShape == param1.flagShape && _loc2_.iconColor == param1.iconColor && _loc2_.iconShape == param1.iconShape)
         {
            return;
         }
         var _loc3_:CommandClanUpdateIcon = GameModel.instance.actionManager.clan.clanUpdate_icon(param1);
      }
      
      private function handler_updateLevel(param1:CommandClanUpdate) : void
      {
         _levelWasChanged.value = false;
         _levelIsUpdating.value = false;
      }
      
      private function handler_roleUpdate() : void
      {
         _playerRank = player.clan.playerRole;
         _signal_roleUpdated.dispatch();
      }
   }
}
