package game.view.gui
{
   import battle.BattleStats;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.RedMarkerGlobalMediator;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.mediator.gui.popup.clan.ClanActivityRewardPopupMediator;
   import game.mediator.gui.popup.clan.ClanEditSettingsPopupMediator;
   import game.mediator.gui.popup.clan.ClanInfoPopupMediator;
   import game.mediator.gui.popup.clan.log.ClanLogPopUpMediator;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopUtils;
   import game.model.user.Player;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.clanscreen.ClanScreenScene;
   import game.view.popup.blasklist.ClanBlackListPopUpMediator;
   import org.osflash.signals.Signal;
   
   public class ClanScreenSceneMediator
   {
       
      
      protected var stashParams:PopupStashEventParams;
      
      private var _signal_clanUpdate:Signal;
      
      private var _signal_spiritsUpdate:Signal;
      
      private var _clanScreen:ClanScreenScene;
      
      private var _player:Player;
      
      private var _titanSoulShopIsAvailable:BooleanPropertyWriteable;
      
      private var _redMarkerMediator:RedMarkerGlobalMediator;
      
      public function ClanScreenSceneMediator(param1:Player)
      {
         _signal_clanUpdate = new Signal();
         _signal_spiritsUpdate = new Signal();
         _titanSoulShopIsAvailable = new BooleanPropertyWriteable();
         super();
         this._player = param1;
         stashParams = new PopupStashEventParams();
         stashParams.windowName = "global_clan";
         _redMarkerMediator = RedMarkerGlobalMediator.instance;
         param1.clan.signal_clanUpdate.add(handler_clanUpdate);
         param1.titans.signal_titanArtifactEvolveStar.add(handler_titanArtifactEvolve);
         param1.titans.signal_titanEvolveStar.add(handler_titanEvolveStar);
         _titanSoulShopIsAvailable.value = TitanSoulShopUtils.hasTitansOnMaxStars(param1);
      }
      
      public function get signal_clanUpdate() : Signal
      {
         return _signal_clanUpdate;
      }
      
      public function get signal_spiritsUpdate() : Signal
      {
         return _signal_spiritsUpdate;
      }
      
      public function get player() : Player
      {
         return _player;
      }
      
      public function get clanScreen() : ClanScreenScene
      {
         return _clanScreen;
      }
      
      public function get clan() : ClanPrivateInfoValueObject
      {
         return player.clan.clan;
      }
      
      public function get canEditClanSettings() : Boolean
      {
         return player.clan.clan && (player.clan.playerRole.permission_edit_settings || player.clan.playerRole.permission_dismiss_member);
      }
      
      public function get titanSoulShopIsAvailable() : BooleanProperty
      {
         return _titanSoulShopIsAvailable;
      }
      
      public function get redMarkerMediator() : RedMarkerGlobalMediator
      {
         return _redMarkerMediator;
      }
      
      public function get totemStar_fire() : int
      {
         return _getTotemStar(4002);
      }
      
      public function get totemStar_water() : int
      {
         return _getTotemStar(4001);
      }
      
      public function get totemStar_earth() : int
      {
         return _getTotemStar(4003);
      }
      
      public function createClanScreen() : ClanScreenScene
      {
         if(clanScreen)
         {
            throw new Error("createClanScreen is called more than once");
         }
         _clanScreen = new ClanScreenScene(this);
         return clanScreen;
      }
      
      public function action_addedToStage() : void
      {
         if(player.clan.clan)
         {
            player.clan.clan.activityUpdateManager.requestUpdate();
         }
      }
      
      public function action_navigate_titanValley() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_VALLEY,stashParams);
      }
      
      public function action_navigate_clanActivity() : void
      {
         var _loc1_:ClanActivityRewardPopupMediator = new ClanActivityRewardPopupMediator(player);
         _loc1_.open(Stash.click("clan_rewards",stashParams));
      }
      
      public function action_navigate_clanRoster() : void
      {
         var _loc1_:ClanInfoPopupMediator = new ClanInfoPopupMediator(player);
         _loc1_.open(Stash.click("clan_info",stashParams));
      }
      
      public function action_navigate_clanLog() : void
      {
         var _loc1_:ClanLogPopUpMediator = new ClanLogPopUpMediator(player);
         _loc1_.open(Stash.click("clan_log",stashParams));
      }
      
      public function action_navigate_clanSettings() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(player.clan.playerRole.permission_edit_settings)
         {
            _loc1_ = new ClanEditSettingsPopupMediator(player);
            _loc1_.open(Stash.click("clan_settings",stashParams));
         }
         else if(player.clan.playerRole.permission_dismiss_member)
         {
            _loc2_ = new ClanBlackListPopUpMediator(player);
            _loc2_.open(Stash.click("clan_black_list",stashParams));
         }
      }
      
      public function action_navigate_dungeon() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_DUNGEON,stashParams);
      }
      
      public function action_navigate_forge() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.TITAN_GIFT,Stash.click("clan_forge",stashParams));
      }
      
      public function action_navigate_summoningCircle() : void
      {
         Game.instance.navigator.navigateToSummoningCircle(Stash.click("summoning_circle",stashParams));
      }
      
      public function action_navigate_titanList() : void
      {
         Game.instance.navigator.navigateToTitans(Stash.click("titans",stashParams));
      }
      
      public function action_navigate_war() : void
      {
         Game.instance.navigator.navigateToMechanic(MechanicStorage.CLAN_PVP,stashParams);
      }
      
      public function action_navigate_titanSoulShop() : void
      {
         Game.instance.navigator.navigateToShop(DataStorage.shop.getByIdent(TitanSoulShopUtils.shopIdent),Stash.click("titan_soul_shop",stashParams));
      }
      
      private function _getTotemStar(param1:int) : int
      {
         var _loc2_:PlayerTitanArtifact = player.titans.getSpiritArtifactById(param1);
         return !!_loc2_?_loc2_.stars:0;
      }
      
      private function handler_titanEvolveStar(param1:PlayerTitanEntry, param2:BattleStats, param3:int) : void
      {
         _titanSoulShopIsAvailable.value = TitanSoulShopUtils.hasTitansOnMaxStars(player);
      }
      
      private function handler_clanUpdate() : void
      {
         _signal_clanUpdate.dispatch();
      }
      
      private function handler_titanArtifactEvolve(param1:PlayerTitanEntry, param2:PlayerTitanArtifact) : void
      {
         if(param2.desc.artifactType == "spirit")
         {
            _signal_spiritsUpdate.dispatch();
         }
      }
   }
}
