package game.mechanics.clan_war.mediator.log
{
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.UserInfo;
   
   public class ClanWarLogBattleEntry
   {
       
      
      private var _wasEmpty:Boolean;
      
      private var _timestamp:Number;
      
      private var _slotId:int;
      
      private var _attacker:ClanWarDefenderValueObject;
      
      private var _defender:ClanWarDefenderValueObject;
      
      private var _victory:Boolean;
      
      private var _replay:Object;
      
      private var _slotPoints:int;
      
      private var _fortificationPoints:int;
      
      public function ClanWarLogBattleEntry()
      {
         super();
      }
      
      public function get wasEmpty() : Boolean
      {
         return _wasEmpty;
      }
      
      public function get timestamp() : Number
      {
         return _timestamp;
      }
      
      public function get slotId() : int
      {
         return _slotId;
      }
      
      public function get attacker() : ClanWarDefenderValueObject
      {
         return _attacker;
      }
      
      public function get defender() : ClanWarDefenderValueObject
      {
         return _defender;
      }
      
      public function get victory() : Boolean
      {
         return _victory;
      }
      
      public function get replay() : Object
      {
         return _replay;
      }
      
      public function get slotPoints() : int
      {
         return _slotPoints;
      }
      
      public function get fortificationPoints() : int
      {
         return _fortificationPoints;
      }
      
      public function parseRawData(param1:Object, param2:Object, param3:Object) : void
      {
         _wasEmpty = param1.previousStatus == "empty";
         _timestamp = param1.time;
         _slotId = param1.slotId;
         _victory = param1.win;
         _fortificationPoints = param1.fortificationPoints;
         _slotPoints = param1.slotPoints;
         if(!_wasEmpty)
         {
            _replay = param3[param1.replayId];
            _attacker = createUserValueObject(param2[param1.attackerId],_replay.attackers);
            _defender = createUserValueObject(param2[param1.defenderId],_replay.defenders[0]);
         }
      }
      
      private function createUserValueObject(param1:UserInfo, param2:Object) : ClanWarDefenderValueObject
      {
         var _loc4_:Vector.<UnitEntryValueObject> = UnitUtils.createUnitEntryVectorFromRawData(param2);
         var _loc3_:* = _loc4_[0].unit.unitType == "hero";
         return new ClanWarDefenderValueObject(null,!!param1?param1.id:"0",param1,_loc4_,_loc3_);
      }
   }
}
