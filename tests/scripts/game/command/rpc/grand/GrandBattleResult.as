package game.command.rpc.grand
{
   import com.progrestar.common.util.assert;
   import game.command.rpc.arena.ArenaBattleResultValueObject;
   import game.command.rpc.arena.BattleResultValueObjectFactory;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class GrandBattleResult
   {
       
      
      private var _attacker:UserInfo;
      
      private var _defender:UserInfo;
      
      private var _isDefensiveBattle:Boolean;
      
      private var _win:Boolean;
      
      private var _oldPlace:int;
      
      private var _newPlace:int;
      
      private var _endTime:int;
      
      public const battles:Vector.<ArenaBattleResultValueObject> = new Vector.<ArenaBattleResultValueObject>();
      
      public function GrandBattleResult(param1:Player, param2:UserInfo, param3:UserInfo, param4:Array)
      {
         super();
         assert(param4.length > 0);
         this._attacker = param2;
         this._defender = param3;
         if(param3)
         {
            this._isDefensiveBattle = param1.id == param3.id;
         }
         else if(param2)
         {
            this._isDefensiveBattle = param1.id != param2.id;
         }
         var _loc5_:Object = null;
         var _loc9_:int = 0;
         var _loc8_:* = param4;
         for each(var _loc6_ in param4)
         {
            this.battles.push(BattleResultValueObjectFactory.parseArenaLogEntry(_loc6_));
            if(_loc6_.result)
            {
               _loc5_ = _loc6_.result;
            }
         }
         this._endTime = param4[param4.length - 1].endTime;
         this._win = _loc5_.win != _isDefensiveBattle;
         this._oldPlace = _loc5_.oldPlace;
         this._newPlace = _loc5_.newPlace;
         var _loc11_:int = 0;
         var _loc10_:* = this.battles;
         for each(var _loc7_ in this.battles)
         {
            _loc7_.oldPlace = this._oldPlace;
            _loc7_.newPlace = this._newPlace;
         }
      }
      
      public function get isDefensiveBattle() : Boolean
      {
         return _isDefensiveBattle;
      }
      
      public function get displayedUser() : UserInfo
      {
         return !!_isDefensiveBattle?_attacker:_defender;
      }
      
      public function get attacker() : UserInfo
      {
         return _attacker;
      }
      
      public function get defender() : UserInfo
      {
         return _defender;
      }
      
      public function get placeDirection() : int
      {
         if(_win && !_isDefensiveBattle)
         {
            return 1;
         }
         if(!_win && _isDefensiveBattle)
         {
            return -1;
         }
         return 0;
      }
      
      public function get place() : int
      {
         return placeDirection > 0?_newPlace:int(_oldPlace);
      }
      
      public function get endTime() : int
      {
         return _endTime;
      }
      
      public function get win() : Boolean
      {
         return _win;
      }
      
      public function get newPlace() : int
      {
         return _newPlace;
      }
      
      public function get oldPlace() : int
      {
         return _oldPlace;
      }
      
      public function applyPlaceFix(param1:int) : void
      {
         _newPlace = param1;
         _oldPlace = param1;
      }
   }
}
