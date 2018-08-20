package game.mechanics.clan_war.model
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import flash.utils.Dictionary;
   import game.command.realtime.SocketClientEvent;
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.mediator.ClanWarPlanScreenMediator;
   import game.mechanics.clan_war.model.command.CommandClanWarFillFortification;
   import game.mechanics.clan_war.model.command.CommandClanWarGetDefence;
   import game.mechanics.clan_war.model.command.CommandClanWarGetStatus;
   import game.mechanics.clan_war.storage.ClanWarFortificationDescription;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.clan.ClanRole;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.clan.ClanMemberValueObject;
   import game.model.user.clan.ClanPrivateInfoValueObject;
   import org.osflash.signals.Signal;
   
   public class PlayerClanWarData
   {
       
      
      private var slotDict:Dictionary;
      
      private var player:Player;
      
      private var _clan:ClanPrivateInfoValueObject;
      
      private var _leagueId:int;
      
      private var _time_nextWar:int;
      
      private var _time_nextLock:int;
      
      private var _signal_defendersUpdate:Signal;
      
      private var _signal_occupiedSlotsCountUpdate:Signal;
      
      private var _signal_warriorsUpdate:Signal;
      
      private var _signal_addWarrior:Signal;
      
      private var _signal_removeWarrior:Signal;
      
      private var _signal_currentWarGetInfo:Signal;
      
      private var _currentWar:PlayerClanWarCurrentInfo;
      
      private var _warriors:Dictionary;
      
      private var _defenders:Vector.<ClanWarDefenderValueObject>;
      
      private var _defendersInitialized:Boolean = false;
      
      private var _property_playerIsWarrior:BooleanPropertyWriteable;
      
      private var _property_playerPermission_defenseManagement:BooleanPropertyWriteable;
      
      private var _property_redMarkerClanTries:IntPropertyWriteable;
      
      private var _property_redMarkerArePointsMax:BooleanPropertyWriteable;
      
      private var _signal_myTriesUpdate:Signal;
      
      private var _signal_attackAvaliableForMeUpdate:Signal;
      
      private var _signal_setDefenseAvaliableUpdate:Signal;
      
      public function PlayerClanWarData(param1:Player)
      {
         slotDict = new Dictionary();
         _signal_defendersUpdate = new Signal();
         _signal_occupiedSlotsCountUpdate = new Signal();
         _signal_warriorsUpdate = new Signal();
         _signal_addWarrior = new Signal(String);
         _signal_removeWarrior = new Signal(String);
         _signal_currentWarGetInfo = new Signal();
         _defenders = new Vector.<ClanWarDefenderValueObject>();
         _property_playerIsWarrior = new BooleanPropertyWriteable();
         _property_playerPermission_defenseManagement = new BooleanPropertyWriteable();
         _property_redMarkerClanTries = new IntPropertyWriteable();
         _property_redMarkerArePointsMax = new BooleanPropertyWriteable();
         _signal_myTriesUpdate = new Signal(int);
         _signal_attackAvaliableForMeUpdate = new Signal();
         _signal_setDefenseAvaliableUpdate = new Signal();
         super();
         this.player = param1;
         _property_playerIsWarrior.signal_update.add(handler_updatePlayerPermissions);
         _property_playerPermission_defenseManagement.signal_update.add(handler_updatePlayerPermissions);
         _property_redMarkerArePointsMax.signal_update.add(handler_propertyArePointsMaxUpdate);
         _signal_myTriesUpdate.add(handler_myTriesUpdateLocal);
         _signal_warriorsUpdate.add(handler_warriorsUpdateLocal);
         _signal_defendersUpdate.add(handler_defendersUpdateLocal);
         _signal_occupiedSlotsCountUpdate.add(handler_occupiedSlotsCountUpdateLocal);
      }
      
      public function get playerClan() : ClanPrivateInfoValueObject
      {
         return _clan;
      }
      
      public function get leagueId() : int
      {
         return _leagueId;
      }
      
      public function get time_nextWar() : int
      {
         return _time_nextWar;
      }
      
      public function get time_nextLock() : int
      {
         return _time_nextLock;
      }
      
      public function get signal_defendersUpdate() : Signal
      {
         return _signal_defendersUpdate;
      }
      
      public function get signal_occupiedSlotsCountUpdate() : Signal
      {
         return _signal_occupiedSlotsCountUpdate;
      }
      
      public function get signal_warriorsUpdate() : Signal
      {
         return _signal_warriorsUpdate;
      }
      
      public function get signal_addWarrior() : Signal
      {
         return _signal_addWarrior;
      }
      
      public function get signal_removeWarrior() : Signal
      {
         return _signal_removeWarrior;
      }
      
      public function get signal_currentWarGetInfo() : Signal
      {
         return _signal_currentWarGetInfo;
      }
      
      public function get currentWar() : PlayerClanWarCurrentInfo
      {
         return _currentWar;
      }
      
      public function get warriorsCount() : int
      {
         var _loc1_:uint = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _warriors;
         for(var _loc2_ in _warriors)
         {
            if(_warriors[_loc2_])
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function get defendersInitialized() : Boolean
      {
         return _defendersInitialized;
      }
      
      public function get property_playerIsWarrior() : BooleanProperty
      {
         return _property_playerIsWarrior;
      }
      
      public function get playerPermission_warrior() : Boolean
      {
         return _property_playerIsWarrior.value;
      }
      
      public function get property_playerPermission_defenseManagement() : BooleanProperty
      {
         return _property_playerPermission_defenseManagement;
      }
      
      public function get playerId() : String
      {
         return player.id;
      }
      
      public function get property_redMarkerClanTries() : IntProperty
      {
         return _property_redMarkerClanTries;
      }
      
      public function get property_redMarkerArePointsMax() : BooleanProperty
      {
         return _property_redMarkerArePointsMax;
      }
      
      public function get attackAvaliableForMe() : Boolean
      {
         return currentWar != null && (currentWar.myTries.value > 0 && !property_redMarkerArePointsMax.value);
      }
      
      public function get signal_myTriesUpdate() : Signal
      {
         return _signal_myTriesUpdate;
      }
      
      public function get signal_attackAvaliableForMeUpdate() : Signal
      {
         return _signal_attackAvaliableForMeUpdate;
      }
      
      public function get setDefenseAvaliable() : Boolean
      {
         var _loc2_:* = time_nextWar < time_nextLock;
         var _loc1_:Boolean = player.clan.playerRole.code == 255 || player.clan.playerRole.code == 4;
         return !_loc2_ && _loc1_ && (!redMarkerState_allWarriorsAreDefenders || redMarkerState_canAssignMoreChampions);
      }
      
      public function get redMarkerState_allWarriorsAreDefenders() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Object = {};
         _loc1_ = 0;
         while(_loc1_ < _defenders.length)
         {
            if(_defenders[_loc1_].currentSlot > 0)
            {
               _loc2_[_defenders[_loc1_].userId] = _defenders[_loc1_].userId;
            }
            _loc1_++;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _warriors;
         for(var _loc3_ in _warriors)
         {
            if(!_loc2_.hasOwnProperty(_loc3_) && _warriors[_loc3_])
            {
               return false;
            }
         }
         return true;
      }
      
      public function get redMarkerState_canAssignMoreChampions() : Boolean
      {
         var _loc1_:int = 0;
         if(_warriors && warriorsCount < DataStorage.clanWar.getLeagueById(_leagueId).maxChampions)
         {
            _loc1_ = 0;
            while(_loc1_ < player.clan.clan.members.length)
            {
               if(!_warriors[player.clan.clan.members[_loc1_].id])
               {
                  if(getDefenderByUid(player.clan.clan.members[_loc1_].id,true) || getDefenderByUid(player.clan.clan.members[_loc1_].id,false))
                  {
                     if(!player.clan.clan.members[_loc1_].wasChampion)
                     {
                        return true;
                     }
                  }
               }
               _loc1_++;
            }
         }
         return false;
      }
      
      public function get signal_setDefenseAvaliableUpdate() : Signal
      {
         return _signal_setDefenseAvaliableUpdate;
      }
      
      public function init(param1:Object, param2:Object) : void
      {
         player.clan.signal_clanUpdate.add(handler_clanUpdate);
         player.clan.signal_roleUpdate.add(handler_roleUpdate);
         _property_redMarkerClanTries.value = int(param2.tries);
         _property_redMarkerArePointsMax.value = Boolean(param2.arePointsMax);
         if(param1)
         {
            _leagueId = param1.defence.league;
            parseDefenders(param1.defence);
            parseWarState(param1.warInfo);
         }
      }
      
      public function action_takeEmptySlots() : void
      {
      }
      
      public function action_removeDefender(param1:ClanWarPlanSlotValueObject) : void
      {
         action_fillFortificationWithDefender(param1,null);
      }
      
      public function action_filterDefenders(param1:ClanWarPlanSlotValueObject) : Vector.<ClanWarDefenderValueObject>
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<ClanWarDefenderValueObject> = new Vector.<ClanWarDefenderValueObject>();
         var _loc2_:int = _defenders.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            if(_defenders[_loc4_].isHeroTeam == param1.desc.isHeroSlot)
            {
               _loc3_.push(_defenders[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function action_fillFortificationWithDefender(param1:ClanWarPlanSlotValueObject, param2:ClanWarDefenderValueObject) : void
      {
         var _loc3_:CommandClanWarFillFortification = GameModel.instance.actionManager.clanWar.clanWarFillFortification(param1,param2);
         _loc3_.signal_complete.add(handler_fillFortificationResult);
      }
      
      public function action_fillFortificationWithPlayer(param1:ClanWarPlanSlotValueObject) : void
      {
         var _loc2_:ClanWarDefenderValueObject = getDefenderByUid(GameModel.instance.player.id,param1.desc.isHeroSlot);
         action_fillFortificationWithDefender(param1,_loc2_);
      }
      
      public function action_getStatus() : CommandClanWarGetStatus
      {
         var _loc1_:CommandClanWarGetStatus = GameModel.instance.actionManager.clanWar.clanWarGetStatus();
         _loc1_.signal_complete.add(handler_complete_getStatus);
         return _loc1_;
      }
      
      public function action_updateDefenderData() : CommandClanWarGetDefence
      {
         var _loc1_:CommandClanWarGetDefence = GameModel.instance.actionManager.clanWar.clanWarGetDefence();
         _loc1_.signal_complete.add(handler_complete_getDefence);
         return _loc1_;
      }
      
      public function action_handleRoleUpdate(param1:ClanRole) : void
      {
         _property_playerPermission_defenseManagement.value = param1 != null && param1.permission_edit_champion_status;
      }
      
      public function action_clanWarEnableWarrior(param1:Array, param2:Array) : void
      {
         GameModel.instance.actionManager.clanWar.clanWarEnableWarrior(param1,param2);
      }
      
      public function getSlots(param1:ClanWarFortificationDescription) : Vector.<ClanWarPlanSlotValueObject>
      {
         var _loc3_:Vector.<ClanWarPlanSlotValueObject> = new Vector.<ClanWarPlanSlotValueObject>();
         var _loc5_:int = 0;
         var _loc4_:* = slotDict;
         for each(var _loc2_ in slotDict)
         {
            if(_loc2_.desc.fortificationId == param1.id)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getUserIsWarrior(param1:UserInfo) : Boolean
      {
         return param1 && _warriors && _warriors[param1.id];
      }
      
      public function getPlayerTeam(param1:Boolean) : ClanWarDefenderValueObject
      {
         return getUserTeam(player.id,param1);
      }
      
      public function getUserTeam(param1:String, param2:Boolean) : ClanWarDefenderValueObject
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _defenders.length)
         {
            if(_defenders[_loc3_].userId == param1 && (_defenders[_loc3_].currentSlotDesc && _defenders[_loc3_].currentSlotDesc.isHeroSlot == param2))
            {
               return _defenders[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public function getDefenderByUid(param1:String, param2:Boolean) : ClanWarDefenderValueObject
      {
         var _loc4_:int = 0;
         var _loc3_:int = _defenders.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_defenders[_loc4_].userId == param1 && _defenders[_loc4_].isHeroTeam == param2)
            {
               return _defenders[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      public function countOccupiedDefenseSlots() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = slotDict;
         for each(var _loc2_ in slotDict)
         {
            if(_loc2_.defender)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function setWarriorsStatus(param1:Array, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _warriors[param1[_loc3_]] = true;
               signal_addWarrior.dispatch(param1[_loc3_]);
               _loc3_++;
            }
         }
         if(param2)
         {
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               _warriors[param2[_loc3_]] = false;
               removeNonWarriorFromDefence(param2[_loc3_]);
               signal_removeWarrior.dispatch(param2[_loc3_]);
               _loc3_++;
            }
         }
         _property_playerIsWarrior.value = _warriors[player.id];
         _signal_warriorsUpdate.dispatch();
      }
      
      private function setSlotDefender(param1:ClanWarPlanSlotValueObject, param2:ClanWarDefenderValueObject) : void
      {
         var _loc3_:* = null;
         if(param1.defender)
         {
            param1.defender.internal_setCurrentSlot(0);
         }
         if(param2 && param2.currentSlot)
         {
            _loc3_ = slotDict[param2.currentSlot];
            _loc3_.internal_setDefender(null);
         }
         param1.internal_setDefender(param2);
         if(param2)
         {
            param2.internal_setCurrentSlot(param1.id);
         }
      }
      
      private function parseWarState(param1:Object) : void
      {
         if(param1 is Array && (param1 as Array).length == 0)
         {
            param1 = null;
         }
         if(param1 && param1.enemyClan)
         {
            _currentWar = new PlayerClanWarCurrentInfo(param1,player.clan,player);
            _currentWar.myTries.signal_update.add(handler_myTriesUpdate);
            _property_redMarkerClanTries.value = _currentWar.myTries.value;
         }
         else
         {
            _currentWar = null;
         }
         _time_nextWar = int(param1.nextWarTime);
         _time_nextLock = int(param1.nextLockTime);
         _property_redMarkerArePointsMax.value = Boolean(param1.arePointsMax);
         _signal_currentWarGetInfo.dispatch();
      }
      
      private function parseDefenders(param1:Object) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         _warriors = new Dictionary();
         var _loc9_:int = 0;
         var _loc8_:* = param1.warriors;
         for(var _loc6_ in param1.warriors)
         {
            _warriors[_loc6_] = param1.warriors[_loc6_] == 1;
         }
         _property_playerIsWarrior.value = _warriors[player.id];
         var _loc11_:int = 0;
         var _loc10_:* = param1.teams;
         for each(var _loc3_ in param1.teams)
         {
            if(_loc3_.clanDefence_heroes != null)
            {
               setupDefender(_loc3_.userId,_loc3_.clanDefence_heroes.units,true);
            }
            if(_loc3_.clanDefence_titans != null)
            {
               setupDefender(_loc3_.userId,_loc3_.clanDefence_titans.units,false);
            }
         }
         var _loc2_:Object = param1.slots;
         var _loc13_:int = 0;
         var _loc12_:* = _loc2_;
         for(var _loc4_ in _loc2_)
         {
            _loc5_ = slotDict[_loc4_];
            if(_loc5_ == null)
            {
               _loc5_ = new ClanWarPlanSlotValueObject(_loc4_,this);
               slotDict[_loc4_] = _loc5_;
            }
            _loc7_ = getDefenderByUid(_loc2_[_loc4_],_loc5_.desc.isHeroSlot);
            setSlotDefender(_loc5_,_loc7_);
         }
         _defendersInitialized = true;
         resubscribeForClan();
         _signal_defendersUpdate.dispatch();
         _signal_occupiedSlotsCountUpdate.dispatch();
         _signal_warriorsUpdate.dispatch();
      }
      
      private function setupDefender(param1:String, param2:Object, param3:Boolean) : void
      {
         var _loc5_:ClanWarDefenderValueObject = getDefenderByUid(param1,param3);
         var _loc4_:Vector.<UnitEntryValueObject> = UnitUtils.createUnitEntryVectorFromRawData(param2);
         if(_loc5_)
         {
            _loc5_.internal_updateTeam(_loc4_);
         }
         else
         {
            _loc5_ = new ClanWarDefenderValueObject(null,param1,player.clan.clan.getMemberById(param1),_loc4_,param3);
            _defenders.push(_loc5_);
         }
      }
      
      private function resubscribeForClan() : void
      {
         if(player.clan.clan == _clan || !_defendersInitialized)
         {
            return;
         }
         if(_clan)
         {
            _clan.signal_newMember.remove(handler_newClanMember);
            _clan.signal_dismissedMember.remove(handler_dismissedClanMember);
         }
         _clan = player.clan.clan;
         if(_clan)
         {
            _clan.signal_newMember.add(handler_newClanMember);
            _clan.signal_dismissedMember.add(handler_dismissedClanMember);
         }
         else
         {
            _defendersInitialized = false;
         }
      }
      
      private function handler_newClanMember(param1:ClanMemberValueObject) : void
      {
      }
      
      private function handler_dismissedClanMember(param1:ClanMemberValueObject) : void
      {
         if(_warriors[param1.id])
         {
            removeNonWarriorFromDefence(param1.id);
            signal_removeWarrior.dispatch(param1.id);
            _signal_warriorsUpdate.dispatch();
         }
      }
      
      private function handler_clanUpdate() : void
      {
         resubscribeForClan();
      }
      
      private function handler_roleUpdate() : void
      {
         setDefenseAvaliableUpdate();
      }
      
      public function handler_message_setDefenseTeam(param1:SocketClientEvent) : void
      {
         if(!defendersInitialized)
         {
            return;
         }
         var _loc3_:Object = param1.data.body;
         var _loc2_:* = _loc3_.type == "clanDefence_heroes";
         setupDefender(_loc3_.userId,_loc3_.team.units,_loc2_);
      }
      
      public function handler_message_clanWarFillFortification(param1:SocketClientEvent) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         if(!defendersInitialized)
         {
            return;
         }
         var _loc2_:Object = param1.data.body;
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_.slots;
         for(var _loc3_ in _loc2_.slots)
         {
            _loc4_ = slotDict[_loc3_];
            if(_loc4_)
            {
               _loc5_ = _loc2_.slots[_loc3_];
               _loc6_ = getDefenderByUid(_loc5_,_loc4_.isHeroSlot);
               setSlotDefender(_loc4_,_loc6_);
            }
         }
         _signal_occupiedSlotsCountUpdate.dispatch();
      }
      
      public function handler_message_clanWarChampion(param1:SocketClientEvent) : void
      {
         if(!defendersInitialized)
         {
            return;
         }
         var _loc2_:Object = param1.data.body;
         var _loc3_:String = _loc2_.userId;
         var _loc4_:Boolean = _loc2_.isChampion;
         if(_loc3_ == player.id)
         {
            _property_playerIsWarrior.value = _loc4_;
         }
         _warriors[_loc3_] = _loc4_;
         if(_loc4_)
         {
            signal_addWarrior.dispatch(_loc3_);
         }
         else
         {
            removeNonWarriorFromDefence(_loc3_);
            signal_removeWarrior.dispatch(_loc3_);
         }
         _signal_warriorsUpdate.dispatch();
      }
      
      public function handler_message_clanWarAttack(param1:SocketClientEvent) : void
      {
         if(currentWar)
         {
            currentWar.handler_message_clanWarAttack(param1);
         }
      }
      
      public function handler_message_clanWarEndBattle(param1:SocketClientEvent) : void
      {
         var _loc2_:Object = param1.data.body;
         if(_loc2_)
         {
            _property_redMarkerArePointsMax.value = Boolean(_loc2_.arePointsMax);
         }
         if(currentWar)
         {
            currentWar.handler_message_clanWarEndBattle(param1);
         }
      }
      
      public function handler_message_clanWarFarmEmpty(param1:SocketClientEvent) : void
      {
         var _loc2_:Object = param1.data.body;
         if(_loc2_)
         {
            _property_redMarkerArePointsMax.value = Boolean(_loc2_.arePointsMax);
         }
         if(currentWar)
         {
            currentWar.handler_message_clanWarFarmEmpty(param1);
         }
      }
      
      private function removeNonWarriorFromDefence(param1:String) : void
      {
         var _loc2_:ClanWarDefenderValueObject = getDefenderByUid(param1,true);
         if(_loc2_ && slotDict[_loc2_.currentSlot])
         {
            setSlotDefender(slotDict[_loc2_.currentSlot],null);
            _signal_occupiedSlotsCountUpdate.dispatch();
         }
         var _loc3_:ClanWarDefenderValueObject = getDefenderByUid(param1,false);
         if(_loc3_ && slotDict[_loc3_.currentSlot])
         {
            setSlotDefender(slotDict[_loc3_.currentSlot],null);
            _signal_occupiedSlotsCountUpdate.dispatch();
         }
      }
      
      private function handler_complete_getStatus(param1:CommandClanWarGetStatus) : void
      {
         _leagueId = param1.result.body.league;
         parseDefenders(param1.result.body);
         parseWarState(param1.result.data["clanWarGetInfo"]);
      }
      
      private function handler_complete_getDefence(param1:CommandClanWarGetDefence) : void
      {
         parseDefenders(param1.result.body);
      }
      
      private function handler_fillFortificationResult(param1:CommandClanWarFillFortification) : void
      {
         var _loc2_:* = null;
         if(!param1.isSuccessful)
         {
            _loc2_ = ClanWarPlanScreenMediator.instance;
            if(_loc2_)
            {
               _loc2_.close();
            }
            PopupList.instance.message("UI_CLAN_WAR_FILL_FORTIFICATION_ERROR");
         }
         else
         {
            setSlotDefender(param1.slot,param1.defender);
            _signal_occupiedSlotsCountUpdate.dispatch();
         }
      }
      
      private function handler_updatePlayerPermissions(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = slotDict;
         for each(var _loc2_ in slotDict)
         {
            _loc2_.internal_updatePermissions();
         }
      }
      
      private function handler_propertyArePointsMaxUpdate(param1:Boolean = false) : void
      {
         attackAvaliableForMeUpdate();
      }
      
      private function handler_myTriesUpdate(param1:int) : void
      {
         signal_myTriesUpdate.dispatch(param1);
      }
      
      private function handler_myTriesUpdateLocal(param1:int) : void
      {
         _property_redMarkerClanTries.value = currentWar.myTries.value;
         attackAvaliableForMeUpdate();
      }
      
      private function handler_warriorsUpdateLocal() : void
      {
         setDefenseAvaliableUpdate();
      }
      
      private function handler_defendersUpdateLocal() : void
      {
         setDefenseAvaliableUpdate();
      }
      
      private function handler_occupiedSlotsCountUpdateLocal() : void
      {
         setDefenseAvaliableUpdate();
      }
      
      private function attackAvaliableForMeUpdate() : void
      {
         signal_attackAvaliableForMeUpdate.dispatch();
      }
      
      private function setDefenseAvaliableUpdate() : void
      {
         signal_setDefenseAvaliableUpdate.dispatch();
      }
   }
}
