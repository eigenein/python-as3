package game.model.user.hero
{
   import flash.utils.Dictionary;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.boss.storage.BossTypeDescription;
   import game.mechanics.dungeon.model.state.DungeonFloorElement;
   import game.model.GameModel;
   
   public class PlayerTeamData
   {
       
      
      private var byActivityType:Dictionary;
      
      private var _grandTeams:Vector.<Vector.<UnitDescription>>;
      
      private var filterCache_minLevel:int;
      
      public function PlayerTeamData()
      {
         super();
         byActivityType = new Dictionary();
      }
      
      public function get grandTeams() : Vector.<Vector.<UnitDescription>>
      {
         return _grandTeams;
      }
      
      public function set grandTeams(param1:Vector.<Vector.<UnitDescription>>) : void
      {
         if(!param1 || param1.length != 3)
         {
            return;
         }
         _grandTeams = param1;
      }
      
      public function init(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _grandTeams = new Vector.<Vector.<UnitDescription>>(0);
         if(param1.grand)
         {
            _loc3_ = param1.grand.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _grandTeams.push(createTeam(param1.grand[_loc2_]));
               _loc2_++;
            }
         }
         while(_loc2_ < 3)
         {
            _grandTeams.push(createTeam(null));
            _loc2_++;
         }
         delete param1.grand;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc4_ in param1)
         {
            if(!byActivityType[_loc4_])
            {
               byActivityType[_loc4_] = createTeam(param1[_loc4_] as Array);
            }
         }
      }
      
      public function getByActivity(param1:MechanicDescription) : Vector.<UnitDescription>
      {
         filterCache_minLevel = param1.minHeroLevel;
         var _loc2_:Vector.<UnitDescription> = byActivityType[param1.teamType];
         if(_loc2_)
         {
            return _loc2_.filter(filter_availableForMechanics);
         }
         return null;
      }
      
      public function getByBossType(param1:BossTypeDescription) : Vector.<UnitDescription>
      {
         var _loc2_:MechanicDescription = MechanicStorage.BOSS;
         filterCache_minLevel = _loc2_.minHeroLevel;
         var _loc3_:Vector.<UnitDescription> = byActivityType[_loc2_.type + "_" + param1.id];
         if(_loc3_)
         {
            return _loc3_.filter(filter_availableForMechanics);
         }
         return null;
      }
      
      public function getByDungeonElement(param1:DungeonFloorElement) : Vector.<UnitDescription>
      {
         var _loc2_:MechanicDescription = MechanicStorage.CLAN_DUNGEON;
         filterCache_minLevel = _loc2_.minHeroLevel;
         var _loc3_:Vector.<UnitDescription> = byActivityType[getActivityTypeByDungeonFloorElement(param1)];
         if(_loc3_)
         {
            return _loc3_.filter(filter_availableForMechanics);
         }
         return null;
      }
      
      public function getClanWarTeam(param1:Boolean, param2:Boolean) : Vector.<UnitDescription>
      {
         return byActivityType[getActivityTypeForClanPvp(param1,param2)];
      }
      
      public function saveClanWarsTeam(param1:Vector.<UnitDescription>, param2:Boolean, param3:Boolean) : void
      {
         byActivityType[getActivityTypeForClanPvp(param2,param3)] = param1;
      }
      
      public function saveTeam(param1:Vector.<UnitDescription>, param2:MechanicDescription) : void
      {
         byActivityType[param2.teamType] = param1;
      }
      
      public function saveTeamByBossDescription(param1:Vector.<UnitDescription>, param2:BossTypeDescription) : void
      {
         var _loc3_:MechanicDescription = MechanicStorage.BOSS;
         byActivityType[_loc3_.type + "_" + param2.id] = param1;
      }
      
      public function saveTeamByDungeonElement(param1:Vector.<UnitDescription>, param2:DungeonFloorElement) : void
      {
         byActivityType[getActivityTypeByDungeonFloorElement(param2)] = param1;
      }
      
      protected function getActivityTypeByDungeonFloorElement(param1:DungeonFloorElement) : String
      {
         if(param1 != null)
         {
            return "dungeon_" + param1.ident;
         }
         return "dungeon_hero";
      }
      
      protected function getActivityTypeForClanPvp(param1:Boolean, param2:Boolean) : String
      {
         var _loc3_:String = "";
         if(param1)
         {
            _loc3_ = "clanDefence";
            if(param2)
            {
               _loc3_ = _loc3_ + "_titans";
            }
            else
            {
               _loc3_ = _loc3_ + "_heroes";
            }
         }
         else
         {
            _loc3_ = "clan_pvp";
            if(param2)
            {
               _loc3_ = _loc3_ + "_titan";
            }
            else
            {
               _loc3_ = _loc3_ + "_hero";
            }
         }
         return _loc3_;
      }
      
      protected function createTeam(param1:Array) : Vector.<UnitDescription>
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<UnitDescription> = new Vector.<UnitDescription>(0);
         if(!param1)
         {
            return _loc2_;
         }
         var _loc4_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_.push(DataStorage.hero.getUnitById(param1[_loc3_]));
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function filter_availableForMechanics(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(param1.unitType == "hero")
         {
            _loc4_ = GameModel.instance.player.heroes.getById(param1.id);
            if(_loc4_ && _loc4_.level.level >= filterCache_minLevel)
            {
               return true;
            }
            return false;
         }
         if(param1.unitType == "titan")
         {
            _loc5_ = GameModel.instance.player.titans.getById(param1.id);
            if(_loc5_ && _loc5_.level.level >= filterCache_minLevel)
            {
               return true;
            }
            return false;
         }
         return false;
      }
   }
}
