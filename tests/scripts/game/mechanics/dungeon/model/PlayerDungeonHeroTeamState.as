package game.mechanics.dungeon.model
{
   import flash.utils.Dictionary;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.tower.TowerHeroState;
   
   public class PlayerDungeonHeroTeamState
   {
       
      
      private var map:Dictionary;
      
      public function PlayerDungeonHeroTeamState()
      {
         map = new Dictionary();
         super();
      }
      
      public function get allDead() : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function clear() : void
      {
         map = new Dictionary();
      }
      
      public function parse(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            _loc4_ = map[_loc3_];
            if(!_loc4_)
            {
               _loc4_ = new TowerHeroState(_loc2_);
               map[_loc3_] = new TowerHeroState(_loc2_);
            }
            else
            {
               _loc4_.setup(_loc2_);
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = map;
         for(_loc3_ in map)
         {
            if(!param1[_loc3_])
            {
               _loc4_ = map[_loc3_];
               _loc4_.hp = _loc4_.maxHp;
               _loc4_.energy = 0;
               _loc4_.isDead = false;
            }
         }
      }
      
      public function getHeroState(param1:int) : TowerHeroState
      {
         return map[param1];
      }
   }
}
