package game.mechanics.clan_war.model
{
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   import game.command.realtime.SocketClientEvent;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.command.CommandClanWarAttack;
   import game.mechanics.clan_war.model.command.CommandClanWarEndBattle;
   import game.mechanics.clan_war.model.command.CommandClanWarTakeEmptySlots;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mechanics.clan_war.storage.ClanWarLeagueDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.clan.PlayerClanData;
   
   public class PlayerClanWarCurrentInfo
   {
       
      
      private var _enemySlots:Dictionary;
      
      private var _ourSlots:Dictionary;
      
      private var clan:PlayerClanData;
      
      private var player:Player;
      
      private var _league:ClanWarLeagueDescription;
      
      private var _endTime:int;
      
      private var _ourClanTries:PlayerClanWarParticipantTries;
      
      private var _enemyClanTries:PlayerClanWarParticipantTries;
      
      private var _participant_us:ClanWarParticipantValueObject;
      
      private var _participant_them:ClanWarParticipantValueObject;
      
      private var _enemy:ClanPublicInfoValueObject;
      
      private var _property_points:IntPropertyWriteable;
      
      private var _property_enemyPoints:IntPropertyWriteable;
      
      private var _myTries:IntPropertyWriteable;
      
      private var _clanTries:IntPropertyWriteable;
      
      public const day:ClanWarDayValueObject = new ClanWarDayValueObject();
      
      public const currentBattle:PlayerClanWarCurrentBattle = new PlayerClanWarCurrentBattle();
      
      private var _pointMultiplier:int = 1;
      
      private var _playerPermission_warrior:Boolean;
      
      public function PlayerClanWarCurrentInfo(param1:Object, param2:PlayerClanData, param3:Player)
      {
         _enemySlots = new Dictionary();
         _ourSlots = new Dictionary();
         _property_points = new IntPropertyWriteable();
         _property_enemyPoints = new IntPropertyWriteable();
         _myTries = new IntPropertyWriteable();
         _clanTries = new IntPropertyWriteable();
         super();
         this.player = param3;
         this.clan = param2;
         if(param1.enemyClan is Array)
         {
            if((param1.enemyClan as Array).length != 0)
            {
               _enemy = new ClanPublicInfoValueObject({"clan":param1.enemyClan[0]});
            }
         }
         else
         {
            _enemy = new ClanPublicInfoValueObject({"clan":param1.enemyClan});
         }
         _enemy.parseMembers(param1.enemyClanMembers);
         day.updateFromRawData(param1);
         _property_points.value = param1.points;
         _property_enemyPoints.value = param1.enemyPoints;
         _myTries.value = param1.myTries;
         _clanTries.value = param1.clanTries.clan;
         _pointMultiplier = param1.avgLevel;
         if(_pointMultiplier <= 0)
         {
            _pointMultiplier = 1;
         }
         parseSlots(param1.enemySlots,_enemySlots);
         parseSlots(param1.ourSlots,_ourSlots);
         _participant_us = new ClanWarParticipantValueObject(param2.clan,_property_points);
         _participant_them = new ClanWarParticipantValueObject(enemy,_property_enemyPoints);
         _league = DataStorage.clanWar.getLeagueById(param1.league);
         _ourClanTries = new PlayerClanWarParticipantTries(param1.clanTries,_league.maxAttackAttempts);
         _enemyClanTries = new PlayerClanWarParticipantTries(param1.enemyClanTries,_league.maxAttackAttempts);
         _playerPermission_warrior = _ourClanTries.getUserIsParticipant(param3.id);
         _endTime = param1.endTime;
      }
      
      public function get league() : ClanWarLeagueDescription
      {
         return _league;
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function get ourClanTries() : PlayerClanWarParticipantTries
      {
         return _ourClanTries;
      }
      
      public function get enemyClanTries() : PlayerClanWarParticipantTries
      {
         return _enemyClanTries;
      }
      
      public function get participant_us() : ClanWarParticipantValueObject
      {
         return _participant_us;
      }
      
      public function get participant_them() : ClanWarParticipantValueObject
      {
         return _participant_them;
      }
      
      public function get enemy() : ClanPublicInfoValueObject
      {
         return _enemy;
      }
      
      public function get property_points() : IntProperty
      {
         return _property_points;
      }
      
      public function get property_enemyPoints() : IntProperty
      {
         return _property_enemyPoints;
      }
      
      public function get myTries() : IntProperty
      {
         return _myTries;
      }
      
      public function get clanTries() : IntProperty
      {
         return _clanTries;
      }
      
      public function get pointMultiplier() : int
      {
         return _pointMultiplier;
      }
      
      public function get playerPermission_warrior() : Boolean
      {
         return _playerPermission_warrior;
      }
      
      public function get showClanTries() : Boolean
      {
         return _league.maxAttackAttempts != ourClanTries.personalTriesMaxSum;
      }
      
      public function action_attack(param1:ClanWarSlotValueObject, param2:Vector.<UnitDescription>) : CommandClanWarAttack
      {
         param1.internal_setState(ClanWarSlotState.IN_BATTLE);
         var _loc3_:CommandClanWarAttack = new CommandClanWarAttack(param1,param2);
         GameModel.instance.actionManager.executeRPCCommand(_loc3_);
         _loc3_.onClientExecute(handler_attackCommandExecuted);
         return _loc3_;
      }
      
      public function action_endBattle(param1:ClanWarSlotValueObject, param2:CommandClanWarEndBattle = null) : void
      {
         currentBattle.endCurrentBattle();
         if(!param2)
         {
            return;
         }
         if(param2.success)
         {
            if(param2.victory)
            {
               _captureSlot(param1);
            }
            else
            {
               param1.internal_setState(ClanWarSlotState.READY);
            }
            param1.internal_setPointsFarmed(param2.slotPointsFarmed);
            param1.internal_setDefenderTeamHP(param2.result.body.slot.team[0]);
            _property_points.value = param2.ourClanPoints;
            _property_enemyPoints.value = param2.enemyClanPoints;
         }
         else
         {
            _myTries.value++;
         }
      }
      
      public function action_takeEmptySlots() : void
      {
         var _loc1_:CommandClanWarTakeEmptySlots = GameModel.instance.actionManager.clanWar.clanWarTakeEmptySlots();
         _loc1_.signal_complete.add(handler_takeEmptySlotsCommandExecuted);
      }
      
      public function getIsTierAvailable(param1:int) : Boolean
      {
         return getUnlockedTiers()[param1];
      }
      
      public function getEnemySlotsByFortification(param1:ClanWarFortificationDescription) : Vector.<ClanWarSlotValueObject>
      {
         return getSlotsByFortification(_enemySlots,param1);
      }
      
      public function getOurSlotsByFortification(param1:ClanWarFortificationDescription) : Vector.<ClanWarSlotValueObject>
      {
         return getSlotsByFortification(_ourSlots,param1);
      }
      
      public function getEnemyUserTeam(param1:String, param2:Boolean) : ClanWarDefenderValueObject
      {
         var _loc5_:int = 0;
         var _loc4_:* = _enemySlots;
         for each(var _loc3_ in _enemySlots)
         {
            if(_loc3_.defender && _loc3_.defender.userId == param1 && _loc3_.defender.isHeroTeam == param2)
            {
               return _loc3_.defender;
            }
         }
         return null;
      }
      
      public function getOurUserTeam(param1:String, param2:Boolean) : ClanWarDefenderValueObject
      {
         var _loc5_:int = 0;
         var _loc4_:* = _ourSlots;
         for each(var _loc3_ in _ourSlots)
         {
            if(_loc3_.defender && _loc3_.defender.userId == param1 && _loc3_.defender.isHeroTeam == param2)
            {
               return _loc3_.defender;
            }
         }
         return null;
      }
      
      public function getSlotsByFortification(param1:Dictionary, param2:ClanWarFortificationDescription) : Vector.<ClanWarSlotValueObject>
      {
         var _loc3_:Vector.<ClanWarSlotValueObject> = new Vector.<ClanWarSlotValueObject>();
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.fortificationDesc == param2)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      private function getUnlockedTiers() : Dictionary
      {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc8_:int = 0;
         var _loc1_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:Dictionary = new Dictionary();
         _loc2_[1] = true;
         var _loc7_:Vector.<ClanWarFortificationDescription> = DataStorage.clanWar.getFortificationList();
         var _loc3_:int = _loc7_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = getSlotsByFortification(_enemySlots,_loc7_[_loc4_]);
            _loc8_ = _loc5_.length;
            _loc1_ = true;
            _loc6_ = 0;
            while(_loc6_ < _loc8_)
            {
               if(_loc5_[_loc6_].slotState != ClanWarSlotState.DEFEATED)
               {
                  _loc1_ = false;
               }
               _loc6_++;
            }
            if(_loc1_ && _loc7_[_loc4_].tierUnlock)
            {
               _loc2_[_loc7_[_loc4_].tierUnlock] = true;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function parseSlots(param1:Object, param2:Dictionary) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            _loc3_ = new ClanWarSlotValueObject(_loc4_,param1[_loc4_],_pointMultiplier,player.clan.clanWarData);
            param2[_loc4_] = _loc3_;
         }
         updateTiers();
      }
      
      private function _captureSlot(param1:ClanWarSlotValueObject) : void
      {
         param1.internal_setState(ClanWarSlotState.DEFEATED);
         updateTiers();
      }
      
      private function updateTiers() : void
      {
         var _loc2_:* = null;
         var _loc1_:Dictionary = getUnlockedTiers();
         var _loc4_:int = 0;
         var _loc3_:* = _enemySlots;
         for each(_loc2_ in _enemySlots)
         {
            _loc2_.internal_setTierAvailability(_loc1_[_loc2_.fortificationDesc.tier]);
         }
         var _loc6_:int = 0;
         var _loc5_:* = _ourSlots;
         for each(_loc2_ in _ourSlots)
         {
            _loc2_.internal_setTierAvailability(_loc1_[_loc2_.fortificationDesc.tier]);
         }
      }
      
      private function handler_takeEmptySlotsCommandExecuted(param1:CommandClanWarTakeEmptySlots) : void
      {
         var _loc2_:Dictionary = getUnlockedTiers();
         var _loc5_:int = 0;
         var _loc4_:* = _enemySlots;
         for each(var _loc3_ in _enemySlots)
         {
            if(_loc2_[_loc3_.fortificationDesc.tier] && _loc3_.slotState == ClanWarSlotState.EMPTY)
            {
               _captureSlot(_loc3_);
            }
         }
         if(param1.result && param1.result.body)
         {
            _property_points.value = param1.result.body.totalPoints;
         }
      }
      
      private function handler_attackCommandExecuted(param1:CommandClanWarAttack) : void
      {
         if(!param1.startBattleError)
         {
            _myTries.value--;
            return;
         }
         var _loc2_:String = param1.startBattleError;
         var _loc3_:* = _loc2_;
         if("warEnds" !== _loc3_)
         {
            if("slotDefeated" !== _loc3_)
            {
               if("slotInBattle" !== _loc3_)
               {
                  if("clanTriesOver" === _loc3_)
                  {
                     _clanTries.value = 0;
                  }
               }
               else
               {
                  param1.slot.internal_setState(ClanWarSlotState.IN_BATTLE);
               }
            }
            else
            {
               _captureSlot(param1.slot);
            }
         }
      }
      
      public function handler_message_clanWarEndBattle(param1:SocketClientEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:Object = param1.data.body;
         if(_loc2_.attackClanId == participant_them.info.id)
         {
            _loc3_ = _ourSlots[_loc2_.slot];
         }
         else
         {
            _loc3_ = _enemySlots[_loc2_.slot];
         }
         if(_loc3_)
         {
            _loc4_ = ClanWarSlotState.getStatus(_loc2_.state.status);
            if(_loc4_ == ClanWarSlotState.DEFEATED)
            {
               _captureSlot(_loc3_);
            }
            else
            {
               _loc3_.internal_setState(ClanWarSlotState.READY);
            }
            _loc3_.internal_setDefenderTeamHP(_loc2_.state.team[0]);
            _loc3_.internal_setPointsFarmed(_loc2_.state.pointsFarmed);
         }
      }
      
      public function handler_message_clanWarAttack(param1:SocketClientEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:Object = param1.data.body;
         if(_loc2_.attackClanId == participant_them.info.id)
         {
            _loc3_ = _ourSlots[_loc2_.slot];
            _enemyClanTries.decrementUserTries(_loc2_.attackerId);
         }
         else
         {
            _loc3_ = _enemySlots[_loc2_.slot];
            _ourClanTries.decrementUserTries(_loc2_.attackerId);
         }
         if(_loc3_)
         {
            _loc3_.internal_setState(ClanWarSlotState.IN_BATTLE);
         }
      }
      
      public function handler_message_clanWarFarmEmpty(param1:SocketClientEvent) : void
      {
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc3_:Object = param1.data.body;
         var _loc2_:Array = _loc3_.slotIds;
         if(_loc3_.attackClanId == participant_them.info.id)
         {
            _loc5_ = _ourSlots;
            _property_enemyPoints.value = _loc3_.points;
         }
         else
         {
            _loc5_ = _enemySlots;
            _property_points.value = _loc3_.points;
         }
         var _loc4_:int = _loc2_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc7_ = _loc5_[_loc2_[_loc6_]];
            _captureSlot(_loc7_);
            _loc6_++;
         }
      }
   }
}
