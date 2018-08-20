package game.mechanics.titan_arena.mediator
{
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class TitanArenaRoundResultValueObject
   {
       
      
      private var rawTeamIsMe:Boolean;
      
      protected var _team_me:Vector.<UnitEntryValueObject>;
      
      protected var _team_them:Vector.<UnitEntryValueObject>;
      
      protected var _hpPercentState:Vector.<Number>;
      
      public function TitanArenaRoundResultValueObject(param1:Vector.<UnitEntryValueObject>, param2:Vector.<UnitEntryValueObject>, param3:Object, param4:Boolean)
      {
         super();
         this.rawTeamIsMe = param4;
         _team_me = param1;
         _team_them = param2;
         updateHpPercentState(param3);
      }
      
      public function get team_me() : Vector.<UnitEntryValueObject>
      {
         return _team_me;
      }
      
      public function get team_them() : Vector.<UnitEntryValueObject>
      {
         return _team_them;
      }
      
      public function get hpPercentState() : Vector.<Number>
      {
         return _hpPercentState;
      }
      
      protected function updateHpPercentState(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         _hpPercentState = new Vector.<Number>();
         if(!param1)
         {
            return;
         }
         if(rawTeamIsMe)
         {
            _loc2_ = team_me;
         }
         else
         {
            _loc2_ = team_them;
         }
         var _loc3_:int = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1[_loc2_[_loc5_].id].state;
            if(_loc4_)
            {
               _hpPercentState[_loc5_] = _loc4_.hp / _loc4_.maxHp;
            }
            else
            {
               _hpPercentState[_loc5_] = 1;
            }
            _loc5_++;
         }
      }
   }
}
