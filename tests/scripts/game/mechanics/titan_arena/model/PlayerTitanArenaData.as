package game.mechanics.titan_arena.model
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.mediator.TitanArenaDefenseTeamGatherPopupMediator;
   import game.mechanics.titan_arena.mediator.TitanArenaTourEndPopupMediator;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaCompleteTier;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndBattle;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaEndRaid;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaGetStatus;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaSetDefenders;
   import game.mechanics.titan_arena.model.command.CommandTitanArenaStartBattle;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanArenaTrophyData;
   import org.osflash.signals.Signal;
   
   public class PlayerTitanArenaData
   {
      
      public static const STATUS_NOT_PREPARED:String = "not_prepared";
      
      public static const STATUS_PEACE_TIME:String = "peace_time";
      
      public static const STATUS_BATTLE:String = "battle";
       
      
      private var trophies:Vector.<PlayerTitanArenaTrophyData>;
      
      private var _maxTier:int;
      
      private var _hasChestReward:BooleanPropertyWriteable;
      
      private var _canUpdateDefenders:BooleanPropertyWriteable;
      
      private var _canRaid:BooleanPropertyWriteable;
      
      private var _property_status:StringPropertyWriteable;
      
      private var _property_score:IntPropertyWriteable;
      
      private var _property_rank:IntPropertyWriteable;
      
      private var _property_league:IntPropertyWriteable;
      
      private var _rivals:Vector.<PlayerTitanArenaEnemy>;
      
      private var _defenders:Vector.<UnitEntryValueObject>;
      
      private var _signal_enemiesUpdate:Signal;
      
      private var _property_tier:IntPropertyWriteable;
      
      private var _signal_defenderTeamUpdate:Signal;
      
      private var _battleStartTs:int;
      
      private var _weekEndTs:int;
      
      private var _nextDayTs:int;
      
      private var _signal_rewardUpdate:Signal;
      
      private var _trophyWithNotFarmedReward:PlayerTitanArenaTrophyData;
      
      private var _dailyRewardsData:PlayerTitanArenaDailyRewardsData;
      
      protected var player:Player;
      
      public function PlayerTitanArenaData(param1:Player)
      {
         trophies = new Vector.<PlayerTitanArenaTrophyData>();
         _hasChestReward = new BooleanPropertyWriteable();
         _canUpdateDefenders = new BooleanPropertyWriteable();
         _canRaid = new BooleanPropertyWriteable();
         _property_status = new StringPropertyWriteable();
         _property_score = new IntPropertyWriteable();
         _property_rank = new IntPropertyWriteable();
         _property_league = new IntPropertyWriteable();
         _signal_enemiesUpdate = new Signal();
         _property_tier = new IntPropertyWriteable();
         _signal_defenderTeamUpdate = new Signal();
         _signal_rewardUpdate = new Signal();
         _dailyRewardsData = new PlayerTitanArenaDailyRewardsData();
         super();
         this.player = param1;
         dailyRewardsData.signal_update.add(handler_dailyRewardsDataUpdate);
      }
      
      public function get maxTier() : int
      {
         return _maxTier;
      }
      
      public function get hasChestReward() : BooleanProperty
      {
         return _hasChestReward;
      }
      
      public function get canUpdateDefenders() : BooleanProperty
      {
         return _canUpdateDefenders;
      }
      
      public function get canRaid() : BooleanProperty
      {
         return _canRaid;
      }
      
      public function get property_status() : StringProperty
      {
         return _property_status;
      }
      
      public function get property_score() : IntProperty
      {
         return _property_score;
      }
      
      public function get property_rank() : IntProperty
      {
         return _property_rank;
      }
      
      public function get property_league() : IntProperty
      {
         return _property_league;
      }
      
      public function get rivals() : Vector.<PlayerTitanArenaEnemy>
      {
         return _rivals;
      }
      
      public function get defenders() : Vector.<UnitEntryValueObject>
      {
         return _defenders;
      }
      
      public function get signal_enemiesUpdate() : Signal
      {
         return _signal_enemiesUpdate;
      }
      
      public function get property_tier() : IntProperty
      {
         return _property_tier;
      }
      
      public function get signal_defenderTeamUpdate() : Signal
      {
         return _signal_defenderTeamUpdate;
      }
      
      public function get battleStartTs() : int
      {
         return _battleStartTs;
      }
      
      public function get weekEndTs() : int
      {
         return _weekEndTs;
      }
      
      public function get nextDayTs() : int
      {
         return _nextDayTs;
      }
      
      public function get signal_rewardUpdate() : Signal
      {
         return _signal_rewardUpdate;
      }
      
      public function get trophyWithNotFarmedReward() : PlayerTitanArenaTrophyData
      {
         return _trophyWithNotFarmedReward;
      }
      
      public function set trophyWithNotFarmedReward(param1:PlayerTitanArenaTrophyData) : void
      {
         if(_trophyWithNotFarmedReward == param1)
         {
            return;
         }
         _trophyWithNotFarmedReward = param1;
         signal_rewardUpdate.dispatch();
      }
      
      public function get dailyRewardsData() : PlayerTitanArenaDailyRewardsData
      {
         return _dailyRewardsData;
      }
      
      public function get isFinalStage() : Boolean
      {
         return _property_tier.value == maxTier;
      }
      
      public function init(param1:*) : void
      {
         update(param1);
      }
      
      public function update(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.status == "peace_time")
         {
            _battleStartTs = param1.battleStartTs;
            _weekEndTs = param1.weekEndTs;
         }
         else
         {
            _defenders = UnitUtils.createUnitEntryVectorFromRawData(param1.defenders);
            _property_score.value = param1.weeklyScore;
            _property_rank.value = param1.rank;
            _property_league.value = param1.league;
            if(_property_tier.value != param1.tier)
            {
               _rivals = new Vector.<PlayerTitanArenaEnemy>();
               var _loc6_:int = 0;
               var _loc5_:* = param1.rivals;
               for(var _loc4_ in param1.rivals)
               {
                  _rivals.push(new PlayerTitanArenaEnemy(param1.rivals[_loc4_]));
               }
               _signal_enemiesUpdate.dispatch();
               _signal_defenderTeamUpdate.dispatch();
            }
            else
            {
               _loc2_ = _rivals.length;
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _rivals[_loc3_].internal_updateFromRawData(param1.rivals[_rivals[_loc3_].id]);
                  _loc3_++;
               }
            }
            _property_tier.value = param1.tier;
            _nextDayTs = param1.nextDayTs;
            _battleStartTs = param1.battleStartTs;
            _weekEndTs = param1.weekEndTs;
            _canUpdateDefenders.value = param1.canUpdateDefenders;
            _canRaid.value = param1.canRaid;
            _maxTier = param1.maxTier;
         }
         _property_status.value = param1.status;
      }
      
      public function updateChestRewardStatus(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         hasChestReward.value = _loc2_ > 0;
      }
      
      function internal_updateOnEndRaid(param1:CommandTitanArenaEndRaid) : void
      {
         _canRaid.value = false;
         _canUpdateDefenders.value = false;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1.battles;
         for each(var _loc2_ in param1.battles)
         {
            _loc2_.enemy.internal_updateFromRawData(_loc2_.rawResult);
            _loc3_ = _loc3_ + _loc2_.scoreEarned;
         }
         dailyRewardsData.addPoints(_loc3_);
         _property_score.value = _property_score.value + _loc3_;
         dailyRewardsData.place = param1.place;
         _property_rank.value = param1.place;
      }
      
      function internal_updateOnEndBattle(param1:CommandTitanArenaEndBattle) : void
      {
         dailyRewardsData.place = param1.place;
         dailyRewardsData.addPoints(param1.pointsEarned_attack + param1.pointsEarned_defense);
         _property_rank.value = param1.place;
         _property_score.value = _property_score.value + (param1.pointsEarned_attack + param1.pointsEarned_defense);
         _canUpdateDefenders.value = false;
      }
      
      public function initTrophies(param1:Object) : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_ = new PlayerTitanArenaTrophyData(_loc2_);
            this.trophies.push(_loc3_);
            if(_loc3_.hasNotFarmedReward)
            {
               trophyWithNotFarmedReward = _loc3_;
            }
         }
      }
      
      public function action_commandGetStatus() : void
      {
         var _loc1_:CommandTitanArenaGetStatus = GameModel.instance.actionManager.titanArena.titanArenaGetStatus();
         _loc1_.signal_complete.add(handler_getStatusCommand);
      }
      
      public function action_updateDefenders() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         if(player.titanArenaData.defenders)
         {
            _loc1_ = player.titanArenaData.defenders.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_.push(player.titanArenaData.defenders[_loc3_].unit);
               _loc3_++;
            }
         }
         var _loc4_:TitanArenaDefenseTeamGatherPopupMediator = new TitanArenaDefenseTeamGatherPopupMediator(player,_loc2_);
         _loc4_.open(null);
         _loc4_.signal_teamGatherComplete.add(handler_setDefenseTeam);
      }
      
      public function action_startBattle(param1:PlayerTitanArenaEnemy, param2:Vector.<UnitDescription>) : CommandTitanArenaStartBattle
      {
         var _loc3_:TitanArenaBattleSequence = new TitanArenaBattleSequence(player,param1,param2);
         _loc3_.signal_complete.add(handler_battleSequenceComplete);
         return _loc3_.start();
      }
      
      public function getTrophyList() : Vector.<PlayerTitanArenaTrophyData>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerTitanArenaTrophyData> = new Vector.<PlayerTitanArenaTrophyData>();
         _loc2_ = 0;
         while(_loc2_ < trophies.length)
         {
            if(trophies[_loc2_].hasCup)
            {
               _loc1_.push(trophies[_loc2_]);
            }
            _loc2_++;
         }
         _loc1_.sort(sortTrophies);
         return _loc1_;
      }
      
      public function action_checkForNextRound() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc1_:Boolean = true;
         if(rivals)
         {
            _loc2_ = rivals.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(!rivals[_loc3_].defeated)
               {
                  _loc1_ = false;
                  break;
               }
               _loc3_++;
            }
         }
         if(_loc1_)
         {
            _loc4_ = GameModel.instance.actionManager.titanArena.titanArenaCompleteTier();
            _loc4_.signal_complete.add(handler_getNextTier);
         }
      }
      
      public function action_testKillEveryone() : void
      {
         var _loc1_:CommandTitanArenaCompleteTier = GameModel.instance.actionManager.titanArena.titanArenaCompleteTier();
         _loc1_.signal_complete.add(handler_getNextTier);
      }
      
      private function sortTrophies(param1:PlayerTitanArenaTrophyData, param2:PlayerTitanArenaTrophyData) : int
      {
         return param1.week - param2.week;
      }
      
      private function handler_getStatusCommand(param1:CommandTitanArenaGetStatus) : void
      {
         update(param1.result.body);
         dailyRewardsData.update(param1.result.data["titanArenaGetDailyReward"]);
         _property_status.signal_update.dispatch(_property_status.value);
      }
      
      private function handler_setDefenseTeam(param1:TitanArenaDefenseTeamGatherPopupMediator) : void
      {
         var _loc2_:CommandTitanArenaSetDefenders = GameModel.instance.actionManager.titanArena.titanArenaSetDefenders(param1.descriptionList);
         _loc2_.signal_complete.add(handler_setDefenseTeamResponse);
         param1.close();
      }
      
      private function handler_setDefenseTeamResponse(param1:CommandTitanArenaSetDefenders) : void
      {
         update(param1.result.body);
         _signal_defenderTeamUpdate.dispatch();
      }
      
      private function handler_battleSequenceComplete(param1:TitanArenaBattleSequence) : void
      {
         action_checkForNextRound();
      }
      
      private function handler_getNextTier(param1:CommandTitanArenaCompleteTier) : void
      {
         update(param1.result.body);
         var _loc2_:TitanArenaTourEndPopupMediator = new TitanArenaTourEndPopupMediator(player,param1);
         _loc2_.open(null);
      }
      
      private function handler_dailyRewardsDataUpdate() : void
      {
         hasChestReward.value = dailyRewardsData.notFarmedRewards.length > 0;
      }
   }
}
