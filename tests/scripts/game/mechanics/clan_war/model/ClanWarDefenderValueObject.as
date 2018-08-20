package game.mechanics.clan_war.model
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.UserInfo;
   import org.osflash.signals.Signal;
   
   public class ClanWarDefenderValueObject
   {
       
      
      private var _hpPercentState:Vector.<Number>;
      
      private var _userId:String;
      
      private var _user:UserInfo;
      
      private var _team:Vector.<UnitEntryValueObject>;
      
      private var _teamPower:int;
      
      private var _isHeroTeam:Boolean;
      
      private var _currentSlot:int;
      
      private var _signal_updateTeam:Signal;
      
      private var _signal_updateCurrentSlot:Signal;
      
      public function ClanWarDefenderValueObject(param1:Object, param2:String, param3:UserInfo, param4:Vector.<UnitEntryValueObject>, param5:Boolean)
      {
         _signal_updateTeam = new Signal(ClanWarDefenderValueObject);
         _signal_updateCurrentSlot = new Signal(ClanWarDefenderValueObject);
         super();
         this._userId = param2;
         this._user = param3;
         this._team = param4;
         updateTeamPower();
         this._isHeroTeam = param5;
         if(param1)
         {
            updateHpPercentState(param1.team[0]);
         }
      }
      
      public function dispose() : void
      {
         _signal_updateTeam.removeAll();
         _signal_updateCurrentSlot.removeAll();
      }
      
      public function get hpPercentState() : Vector.<Number>
      {
         return _hpPercentState;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get user() : UserInfo
      {
         return _user;
      }
      
      public function get team() : Vector.<UnitEntryValueObject>
      {
         return _team;
      }
      
      public function get teamPower() : uint
      {
         return _teamPower;
      }
      
      public function get isHeroTeam() : Boolean
      {
         return _isHeroTeam;
      }
      
      public function get currentSlot() : int
      {
         return _currentSlot;
      }
      
      public function get currentSlotDesc() : ClanWarSlotDescription
      {
         if(!_currentSlot)
         {
            return null;
         }
         return DataStorage.clanWar.getSlotById(_currentSlot);
      }
      
      public function get signal_updateTeam() : Signal
      {
         return _signal_updateTeam;
      }
      
      public function get signal_updateCurrentSlot() : Signal
      {
         return _signal_updateCurrentSlot;
      }
      
      function internal_setCurrentSlot(param1:int) : void
      {
         _currentSlot = param1;
         _signal_updateCurrentSlot.dispatch(this);
      }
      
      function internal_updateTeam(param1:Vector.<UnitEntryValueObject>) : void
      {
         _team = param1;
         updateTeamPower();
         _signal_updateTeam.dispatch(this);
      }
      
      function internal_updateTeamFromRawData(param1:Object) : void
      {
         _hpPercentState = new Vector.<Number>();
         if(!param1)
         {
            return;
         }
         if(!isSameTeam(param1))
         {
            _team = UnitUtils.createUnitEntryVectorFromRawData(param1);
            updateTeamPower();
         }
         updateHpPercentState(param1);
      }
      
      protected function updateHpPercentState(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         _hpPercentState = new Vector.<Number>();
         if(!param1)
         {
            return;
         }
         var _loc2_:int = _team.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_team[_loc4_].id].state;
            _hpPercentState[_loc4_] = _loc3_.hp / _loc3_.maxHp;
            _loc4_++;
         }
         _signal_updateTeam.dispatch(this);
      }
      
      private function updateTeamPower() : void
      {
         var _loc2_:int = 0;
         _teamPower = 0;
         var _loc1_:int = _team.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _teamPower = _teamPower + _team[_loc2_].getPower();
            _loc2_++;
         }
      }
      
      private function isSameTeam(param1:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(var _loc4_ in param1)
         {
            _loc3_++;
         }
         if(_loc3_ != _team.length)
         {
            return false;
         }
         var _loc8_:int = 0;
         var _loc7_:* = _team;
         for each(var _loc2_ in _team)
         {
            if(param1[_loc2_.id] == undefined)
            {
               return false;
            }
         }
         return true;
      }
   }
}
