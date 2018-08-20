package game.mechanics.titan_arena.model
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.IntProperty;
   import engine.core.utils.property.IntPropertyWriteable;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.UserInfo;
   import game.model.user.arena.IUnitEntryValueObjectTeamProvider;
   
   public class PlayerTitanArenaEnemy extends UserInfo implements IUnitEntryValueObjectTeamProvider
   {
       
      
      private var _points_defense:int;
      
      private var _points_attack:int;
      
      protected var _place:int;
      
      protected var _heroes:Vector.<UnitEntryValueObject>;
      
      private var _property_points:IntPropertyWriteable;
      
      private var _hpPercentState:Vector.<Number>;
      
      protected var _power:int;
      
      private var _isBuffed:Boolean;
      
      private var _isBot:Boolean;
      
      private var _powerBuff:int;
      
      public function PlayerTitanArenaEnemy(param1:Object)
      {
         var _loc2_:* = undefined;
         _property_points = new IntPropertyWriteable();
         super();
         if(param1)
         {
            _power = 0;
            if(param1.power)
            {
               _power = param1.power;
            }
            parseHeroes(param1.titans);
            _loc2_ = param1.userData;
            if(_loc2_)
            {
               parse(param1.userData);
            }
            if(!_avatarId)
            {
               _avatarId = 1;
            }
            _id = param1.userId;
            updateHpPercentState(param1.titans);
            _points_attack = param1.attackScore;
            _points_defense = param1.defenceScore;
            _property_points.value = param1.attackScore + param1.defenceScore;
            _powerBuff = param1.powerBuff;
            _isBuffed = _powerBuff > 0;
            _isBot = param1.isBot;
            if(_isBot)
            {
               _nickname = Translate.translate(nickname);
            }
         }
         else
         {
            _place = 0;
         }
      }
      
      public function get points_defense() : int
      {
         return _points_defense;
      }
      
      public function get points_attack() : int
      {
         return _points_attack;
      }
      
      public function get points_attackMax() : int
      {
         return DataStorage.rule.titanArenaRule.pointsTotal_attack;
      }
      
      public function get points_defenseMax() : int
      {
         return DataStorage.rule.titanArenaRule.pointsTotal_defense;
      }
      
      public function get property_points() : IntProperty
      {
         return _property_points;
      }
      
      public function get hpPercentState() : Vector.<Number>
      {
         return _hpPercentState;
      }
      
      public function get maxPoints() : int
      {
         return DataStorage.rule.titanArenaRule.pointsTotal_attack + DataStorage.rule.titanArenaRule.pointsTotal_defense;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function get defeated() : Boolean
      {
         return _points_attack == points_attackMax;
      }
      
      public function get isBuffed() : Boolean
      {
         return _isBuffed;
      }
      
      override public function get isBot() : Boolean
      {
         return _isBot;
      }
      
      public function get powerBuff() : int
      {
         return _powerBuff;
      }
      
      public function getTeam(param1:int) : Vector.<UnitEntryValueObject>
      {
         return _heroes;
      }
      
      function internal_updateFromRawData(param1:Object) : void
      {
         _hpPercentState = new Vector.<Number>();
         _points_defense = Math.max(_points_defense,param1.defenceScore);
         _points_attack = Math.max(_points_attack,param1.attackScore);
         _property_points.value = _points_attack + _points_defense;
         updateHpPercentState(param1.rivalTeam);
      }
      
      protected function parseHeroes(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _heroes = new Vector.<UnitEntryValueObject>();
         if(param1[0] is Array)
         {
            _loc3_ = param1.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               parseTeam(param1[_loc2_]);
               _loc2_++;
            }
         }
         else
         {
            parseTeam(param1);
         }
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
         var _loc2_:int = _heroes.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_heroes[_loc4_].id].state;
            if(_loc3_)
            {
               _hpPercentState[_loc4_] = _loc3_.hp / _loc3_.maxHp;
            }
            else
            {
               _hpPercentState[_loc4_] = 1;
            }
            _loc4_++;
         }
      }
      
      private function parseTeam(param1:*) : void
      {
         var _loc3_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>(0);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
         _heroes = _loc3_;
      }
   }
}
