package game.mediator.gui.popup.mission
{
   import com.progrestar.common.lang.Translate;
   import feathers.core.PopUpManager;
   import game.command.rpc.mission.CommandMissionRaid;
   import game.command.rpc.mission.CommandMissionStart;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.pve.BattleEnemyValueObject;
   import game.data.storage.pve.mission.MissionDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.mediator.gui.popup.hero.HeroEntryValueObject;
   import game.mediator.gui.popup.resourcepanel.ResourcePanelValueObjectGroup;
   import game.mediator.gui.popup.team.TeamGatherByActivityPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupMediator;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryItem;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.model.user.mission.PlayerEliteMissionEntry;
   import game.model.user.mission.PlayerMissionEntry;
   import game.screen.navigator.IRefillableNavigatorResult;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   import game.view.popup.PopupBase;
   import game.view.popup.mission.MissionEnterPopup;
   import game.view.popup.reward.multi.MultiRewardGroupedPopup;
   import idv.cjcat.signals.Signal;
   
   public class MissionEnterPopupMediator extends PopupMediator
   {
       
      
      private var _mission:PlayerMissionEntry;
      
      private var _desc:MissionDescription;
      
      private var _dropListProvider:MissionDropListProvider;
      
      private var _signal_startMission:Signal;
      
      private var _signal_close:Signal;
      
      private var _signal_raidUpdate:Signal;
      
      private var _signal_eliteTriesUpdate:Signal;
      
      private var _enemyList:Vector.<HeroEntryValueObject>;
      
      private var _raidMultipleCount:int;
      
      private var _raidMaxCount:int;
      
      private var _staminaCost:CostData;
      
      private var _itemToLookFor:InventoryItem;
      
      private var _startOnTeamSelect_mediator:TeamGatherPopupMediator;
      
      public function MissionEnterPopupMediator(param1:Player, param2:MissionDescription)
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc8_:Boolean = false;
         var _loc10_:int = 0;
         var _loc7_:int = 0;
         _signal_startMission = new Signal();
         super(param1);
         this._desc = param2;
         this._mission = param1.missions.getByDesc(param2);
         if(_mission is PlayerEliteMissionEntry)
         {
            _loc4_ = _mission as PlayerEliteMissionEntry;
            if(_loc4_.eliteTries)
            {
               _loc4_.eliteTries.signal_update.add(handler_eliteTriesUpdate);
            }
         }
         param1.signal_update.stamina.add(handler_staminaUpdated);
         _signal_raidUpdate = new Signal();
         _signal_eliteTriesUpdate = new Signal();
         var _loc9_:Vector.<BattleEnemyValueObject> = _desc.enemyList.slice();
         _loc9_.sort(_preSortEnemies);
         _enemyList = new Vector.<HeroEntryValueObject>();
         var _loc3_:int = _loc9_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = _loc9_[_loc6_];
            _loc8_ = false;
            _loc10_ = _enemyList.length;
            _loc7_ = 0;
            while(_loc7_ < _loc10_)
            {
               if(_enemyList[_loc7_].hero == _loc5_.hero && _enemyList[_loc7_].heroEntry.getSortPower() == _loc5_.getSortPower())
               {
                  _loc8_ = true;
                  break;
               }
               _loc7_++;
            }
            if(!_loc8_)
            {
               _enemyList.push(new MissionEnemyListValueObject(_loc9_[_loc6_].hero,_loc9_[_loc6_]));
            }
            _loc6_++;
         }
         _enemyList.sort(_postSortEnemies);
         _dropListProvider = new MissionDropListProvider(_desc,param1);
      }
      
      override protected function dispose() : void
      {
         var _loc1_:* = null;
         if(_signal_close)
         {
            _signal_close.dispatch();
            _signal_close.clear();
         }
         if(_mission is PlayerEliteMissionEntry)
         {
            _loc1_ = _mission as PlayerEliteMissionEntry;
            if(_loc1_.eliteTries)
            {
               _loc1_.eliteTries.signal_update.remove(handler_eliteTriesUpdate);
            }
         }
         if(player)
         {
            player.signal_update.stamina.remove(handler_staminaUpdated);
         }
         if(_dropListProvider)
         {
            _dropListProvider.dispose();
         }
         super.dispose();
      }
      
      public function get worldIndex() : int
      {
         return _desc.world;
      }
      
      public function get missionIndex() : int
      {
         return _desc.index;
      }
      
      public function get signal_startMission() : Signal
      {
         return _signal_startMission;
      }
      
      public function get signal_close() : Signal
      {
         if(_signal_close)
         {
            §§push(_signal_close);
         }
         else
         {
            _signal_close = new Signal();
            §§push(new Signal());
         }
         return §§pop();
      }
      
      public function get signal_raidUpdate() : Signal
      {
         return _signal_raidUpdate;
      }
      
      public function get signal_eliteTriesUpdate() : Signal
      {
         return _signal_eliteTriesUpdate;
      }
      
      public function get enemyList() : Vector.<HeroEntryValueObject>
      {
         return _enemyList;
      }
      
      public function get dropListProvider() : MissionDropListProvider
      {
         return _dropListProvider;
      }
      
      public function get eliteTriesAvailable() : int
      {
         var _loc1_:PlayerEliteMissionEntry = _mission as PlayerEliteMissionEntry;
         if(_loc1_ && _loc1_.eliteTries)
         {
            return _loc1_.eliteTries.value;
         }
         return 0;
      }
      
      public function get eliteTriesMax() : int
      {
         var _loc1_:PlayerEliteMissionEntry = _mission as PlayerEliteMissionEntry;
         if(_loc1_ && _loc1_.eliteTries)
         {
            return _loc1_.eliteTries.maxValue;
         }
         return 0;
      }
      
      public function get eliteRefillsLeft() : int
      {
         var _loc1_:PlayerEliteMissionEntry = _mission as PlayerEliteMissionEntry;
         if(_loc1_ && _loc1_.eliteTries)
         {
            return _loc1_.eliteTries.maxRefillCount - _loc1_.eliteTries.refillCount;
         }
         return 0;
      }
      
      public function get isElite() : Boolean
      {
         return _desc.isHeroic;
      }
      
      public function get canRaid() : Boolean
      {
         return _mission && _mission.stars == _desc.maxStarCount;
      }
      
      public function get maxStars() : int
      {
         return _desc.maxStarCount;
      }
      
      public function get stars() : int
      {
         return !!_mission?_mission.stars:0;
      }
      
      public function get raidMultipleCount() : int
      {
         return 10;
      }
      
      public function get raidMaxCount() : int
      {
         var _loc1_:int = Math.floor(player.stamina / _desc.totalCost.stamina);
         if(isElite && DataStorage.rule.heroicMissionUseTriesLimit)
         {
            return Math.min(_loc1_,eliteTriesAvailable);
         }
         return _loc1_;
      }
      
      public function get staminaCost() : CostData
      {
         return _desc.totalCost;
      }
      
      public function get name() : String
      {
         return _desc.name;
      }
      
      public function get textDescription() : String
      {
         return _desc.descText;
      }
      
      override public function get resourcePanelList() : ResourcePanelValueObjectGroup
      {
         var _loc1_:ResourcePanelValueObjectGroup = new ResourcePanelValueObjectGroup(player);
         if(!Tutorial.flags.hideEnterMissionResources)
         {
            _loc1_.requre_stamina(true);
            _loc1_.requre_starmoney(true);
         }
         return _loc1_;
      }
      
      public function set itemToLookFor(param1:InventoryItem) : void
      {
         _itemToLookFor = param1;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new MissionEnterPopup(this);
         _popup.stashParams.windowName = "mission_enter:" + _desc.id;
         return _popup;
      }
      
      public function action_startMission() : void
      {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(showRaidPromo_onStart())
         {
            return;
         }
         if(player.stamina < _desc.totalCost.stamina)
         {
            _loc3_ = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("stamina"),Stash.click("not_enough_stamina",_popup.stashParams));
            _loc3_.closeAfterRefill = true;
            return;
         }
         if(isElite && DataStorage.rule.heroicMissionUseTriesLimit)
         {
            if(eliteTriesAvailable < 1 && eliteTriesMax != 0)
            {
               Game.instance.navigator.navigateToRefillableMission(_mission as PlayerEliteMissionEntry,Stash.click("not_enough_elite_tries",_popup.stashParams));
               return;
            }
         }
         var _loc4_:Boolean = player.heroes.teamGathering.needMissionTeamGathering();
         if(_loc4_)
         {
            _loc1_ = MechanicStorage.MISSION;
            _loc2_ = new TeamGatherByActivityPopupMediator(player,_loc1_);
            _loc2_.signal_teamGatherComplete.addOnce(startOnTeamSelect);
            _loc2_.open(Stash.click("mission_start",_popup.stashParams));
         }
         else
         {
            start(player.heroes.teamGathering.gatherDefaultMissionTeam());
         }
      }
      
      public function action_eliteRefill() : void
      {
         Game.instance.navigator.navigateToRefillableMission(_mission as PlayerEliteMissionEntry,Stash.click("elite_tries_refill",_popup.stashParams));
      }
      
      public function action_raid() : void
      {
         raid(1);
      }
      
      public function action_raidMultuple() : void
      {
         raid(raidMultipleCount);
      }
      
      public function action_raidMax() : void
      {
         raid(raidMaxCount);
      }
      
      private function showRaidPromo_onStart() : Boolean
      {
         var _loc1_:* = null;
         if(player.billingData.getRaidPromoBilling() && _mission && _mission.stars == _mission.desc.maxStarCount && player.sharedObjectStorage.readTimeout("game.mediator.gui.popup.AutoPopupMediator.communityPromo"))
         {
            _loc1_ = new RaidPromoPopupMediator(player);
            _loc1_.open(Stash.click("raid_promo_billing",_popup.stashParams));
            player.sharedObjectStorage.writeTimeout("game.mediator.gui.popup.AutoPopupMediator.communityPromo");
            return true;
         }
         return false;
      }
      
      private function showRaidPromo_onRaid() : Boolean
      {
         var _loc1_:* = null;
         if(player.billingData.getRaidPromoBilling())
         {
            _loc1_ = new RaidPromoPopupMediator(player);
            _loc1_.open(Stash.click("raid_promo_billing",_popup.stashParams));
            return true;
         }
         return false;
      }
      
      private function startOnTeamSelect(param1:TeamGatherPopupMediator) : void
      {
         _startOnTeamSelect_mediator = param1;
         start(param1.playerEntryTeamList);
      }
      
      private function start(param1:Vector.<PlayerHeroEntry>) : void
      {
         var _loc2_:CommandMissionStart = GameModel.instance.actionManager.mission.missionStart(_desc,param1);
         _loc2_.onClientExecute(handler_missionStart);
         _signal_startMission.dispatch();
      }
      
      private function raid(param1:int) : void
      {
         var _loc3_:* = null;
         if(param1 > 1)
         {
            if(player.vipLevel.level < DataStorage.rule.vipRule.missionMultiRaid)
            {
               PopupList.instance.popup_vip_needed(Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_BIG_RAID"),DataStorage.rule.vipRule.missionMultiRaid);
               return;
            }
         }
         else if(player.vipLevel.level < DataStorage.rule.vipRule.missionRaid)
         {
            if(!showRaidPromo_onRaid())
            {
               PopupList.instance.popup_vip_needed(Translate.translate("UI_POPUP_NOT_ENOUGH_VIP_RAID"),DataStorage.rule.vipRule.missionRaid);
            }
            return;
         }
         if(player.stamina < _desc.totalCost.stamina * param1)
         {
            _loc3_ = Game.instance.navigator.navigateToRefillable(DataStorage.refillable.getByIdent("stamina"),Stash.click("not_enough_stamina",_popup.stashParams));
            _loc3_.closeAfterRefill = true;
            return;
         }
         if(isElite && DataStorage.rule.heroicMissionUseTriesLimit)
         {
            if(eliteTriesAvailable < param1)
            {
               Game.instance.navigator.navigateToRefillableMission(_mission as PlayerEliteMissionEntry,Stash.click("not_enough_elite_tries",_popup.stashParams));
               return;
            }
         }
         var _loc2_:CommandMissionRaid = GameModel.instance.actionManager.mission.missionRaid(_desc,param1);
         _loc2_.onClientExecute(onRaidFinished);
      }
      
      private function onRaidFinished(param1:CommandMissionRaid) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc3_:Vector.<RewardData> = new Vector.<RewardData>();
         _loc3_ = _loc3_.concat(param1.rewardList);
         var _loc4_:RaidRewardValueObjectList = new RaidRewardValueObjectList(_loc3_,param1.raidReward);
         if(_itemToLookFor)
         {
            _loc2_ = new InventoryItemValueObject(player,_itemToLookFor);
            if(_itemToLookFor.item is HeroDescription)
            {
               _loc5_ = player.heroes.getById((_itemToLookFor.item as HeroDescription).id);
               if(_loc5_ && _loc5_.star.next)
               {
                  _loc2_.inventoryItem.amount = Math.max(1,_loc5_.star.next.star.evolveFragmentCost);
               }
            }
         }
         var _loc6_:MultiRewardGroupedPopup = new MultiRewardGroupedPopup(_loc4_,_loc2_);
         PopUpManager.addPopUp(_loc6_);
         if(isElite)
         {
            _signal_eliteTriesUpdate.dispatch();
         }
      }
      
      private function handler_eliteTriesUpdate() : void
      {
         _signal_eliteTriesUpdate.dispatch();
         _signal_raidUpdate.dispatch();
      }
      
      private function _preSortEnemies(param1:BattleEnemyValueObject, param2:BattleEnemyValueObject) : int
      {
         return param2.getSortPower() - param1.getSortPower();
      }
      
      private function _postSortEnemies(param1:HeroEntryValueObject, param2:HeroEntryValueObject) : int
      {
         return param2.heroEntry.getSortPower() - param1.heroEntry.getSortPower();
      }
      
      private function handler_missionStart(param1:CommandMissionStart) : void
      {
         close();
         if(_startOnTeamSelect_mediator)
         {
            _startOnTeamSelect_mediator.close();
            _startOnTeamSelect_mediator = null;
         }
      }
      
      private function handler_staminaUpdated() : void
      {
         _signal_raidUpdate.dispatch();
      }
   }
}
