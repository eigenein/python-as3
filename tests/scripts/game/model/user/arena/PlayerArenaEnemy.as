package game.model.user.arena
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.UserInfo;
   
   public class PlayerArenaEnemy extends UserInfo implements IUnitEntryValueObjectTeamProvider
   {
      
      private static const HIDDEN_TEAM:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>(0);
       
      
      protected var _power:int;
      
      protected var _place:int;
      
      protected var _heroes:Vector.<Vector.<UnitEntryValueObject>>;
      
      protected const _isAvailableByRange:BooleanPropertyWriteable = new BooleanPropertyWriteable(true);
      
      public function PlayerArenaEnemy(param1:*)
      {
         var _loc2_:* = undefined;
         super();
         if(param1)
         {
            _id = param1.userId;
            _place = param1.place;
            _power = 0;
            parseHeroes(param1.heroes);
            _power = param1.power;
            _loc2_ = param1.user;
            if(_loc2_)
            {
               parse(param1.user);
            }
            else
            {
               initEmptyUserByHash(int(_id));
            }
            if(!_avatarId)
            {
               _avatarId = 1;
            }
         }
         else
         {
            _place = 0;
         }
      }
      
      public static function parseRawEnemies(param1:*) : Vector.<PlayerArenaEnemy>
      {
         var _loc3_:Vector.<PlayerArenaEnemy> = new Vector.<PlayerArenaEnemy>(0);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(new PlayerArenaEnemy(_loc2_));
         }
         return _loc3_;
      }
      
      private static function sortOnPlace(param1:PlayerArenaEnemy, param2:PlayerArenaEnemy) : int
      {
         return param1.place - param2.place;
      }
      
      public function get name() : String
      {
         return _id + " " + nickname;
      }
      
      public function get place() : int
      {
         return _place;
      }
      
      public function get power() : int
      {
         return _power;
      }
      
      public function getTeam(param1:int) : Vector.<UnitEntryValueObject>
      {
         return param1 < _heroes.length?_heroes[param1]:HIDDEN_TEAM;
      }
      
      public function get isAvailableByRange() : BooleanProperty
      {
         return _isAvailableByRange;
      }
      
      public function isValid() : Boolean
      {
         return _place > 0 && _id.length > 0 && _heroes && _heroes.length > 0;
      }
      
      function setAvailability(param1:Boolean) : void
      {
         _isAvailableByRange.value = param1;
      }
      
      protected function parseHeroes(param1:*) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _heroes = new Vector.<Vector.<UnitEntryValueObject>>(0);
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
      
      protected function initEmptyUserByHash(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = -param1;
         }
         _nickname = DataStorage.nickname.getNicknameBySeed(param1);
         _avatarId = 1 + param1 % 6;
         var _loc7_:int = 0;
         var _loc6_:* = _heroes;
         for each(var _loc3_ in _heroes)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.level > _level)
               {
                  _level = _loc2_.level;
               }
            }
         }
      }
      
      private function parseTeam(param1:*) : void
      {
         var _loc3_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>(0);
         _heroes.push(_loc3_);
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for each(var _loc2_ in param1)
         {
            _loc3_.push(UnitUtils.createEntryValueObjectFromRawData(_loc2_));
         }
      }
   }
}
