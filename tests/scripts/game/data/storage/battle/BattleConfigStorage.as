package game.data.storage.battle
{
   import battle.BattleConfig;
   import com.progrestar.common.util.assert;
   import flash.utils.Dictionary;
   
   public class BattleConfigStorage
   {
       
      
      public const CORE:BattleTypeIdent = new BattleTypeIdent("core");
      
      public const TEST:BattleTypeIdent = new BattleTypeIdent("test");
      
      public const PVP:BattleTypeIdent = new BattleTypeIdent("pvp");
      
      public const PVE:BattleTypeIdent = new BattleTypeIdent("pve");
      
      public const TOWER:BattleTypeIdent = new BattleTypeIdent("tower");
      
      public const BOSS:BattleTypeIdent = new BattleTypeIdent("boss");
      
      public const TITAN:BattleTypeIdent = new BattleTypeIdent("titan_tower");
      
      public const CLAN_PVP:BattleTypeIdent = new BattleTypeIdent("clan_pvp");
      
      public const TITAN_CLAN_PVP:BattleTypeIdent = new BattleTypeIdent("titan_clan_pvp");
      
      public const TITAN_PVP:BattleTypeIdent = new BattleTypeIdent("titan_pvp");
      
      private var dictionary:Dictionary;
      
      public function BattleConfigStorage()
      {
         dictionary = new Dictionary();
         super();
      }
      
      public function get core() : BattleConfig
      {
         return dictionary[CORE.name];
      }
      
      public function get test() : BattleConfig
      {
         return dictionary[TEST.name];
      }
      
      public function get pvp() : BattleConfig
      {
         return dictionary[PVP.name];
      }
      
      public function get pve() : BattleConfig
      {
         return dictionary[PVE.name];
      }
      
      public function get tower() : BattleConfig
      {
         return dictionary[TOWER.name];
      }
      
      public function get boss() : BattleConfig
      {
         return dictionary[BOSS.name];
      }
      
      public function get titan() : BattleConfig
      {
         return dictionary[TITAN.name];
      }
      
      public function get clanPvp() : BattleConfig
      {
         return dictionary[CLAN_PVP.name];
      }
      
      public function get titanClanPvp() : BattleConfig
      {
         return dictionary[TITAN_CLAN_PVP.name];
      }
      
      public function get titanPvp() : BattleConfig
      {
         return dictionary[TITAN_PVP.name];
      }
      
      public function get balancer() : BattleConfig
      {
         return dictionary[PVP.name];
      }
      
      public function init(param1:*) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            dictionary[_loc2_.ident] = createEntry(_loc2_.config);
         }
      }
      
      public function getByIdent(param1:BattleTypeIdent) : BattleConfig
      {
         return dictionary[param1.name];
      }
      
      public function getByName(param1:String) : BattleConfig
      {
         return dictionary[param1];
      }
      
      protected function createEntry(param1:*) : BattleConfig
      {
         var _loc3_:BattleConfig = new BattleConfig();
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc2_ in param1)
         {
            if(_loc3_.hasOwnProperty(_loc2_))
            {
               _loc3_[_loc2_] = parseConfigProperty(param1[_loc2_]);
            }
            else
            {
               assert(false);
            }
         }
         return _loc3_;
      }
      
      private function configPropertyEqual(param1:*, param2:*) : Boolean
      {
         if(param1 is Vector.<String>)
         {
            if(!(param2 && param2[0] && param1.length == param2.length))
            {
               return false;
            }
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for(var _loc3_ in param1)
            {
               if(param1[_loc3_] != param2[_loc3_])
               {
                  return false;
               }
            }
            return true;
         }
         if(Number(param1) == Number(param2) || param1 == param2)
         {
            return true;
         }
         return false;
      }
      
      private function parseConfigProperty(param1:*) : *
      {
         if(param1 is Array && param1[0] is String)
         {
            return Vector.<String>(param1);
         }
         return param1;
      }
   }
}

class BattleTypeIdent
{
    
   
   private var _name:String;
   
   function BattleTypeIdent(param1:String)
   {
      super();
      this._name = param1;
   }
   
   public function get name() : String
   {
      return _name;
   }
}
