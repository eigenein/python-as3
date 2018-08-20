package game.data.storage.arena
{
   public class ArenaDescription
   {
       
      
      public var ident:String;
      
      public var refillableCooldownId:int;
      
      public var refillableBattleId:int;
      
      public function ArenaDescription()
      {
         super();
      }
      
      public function init(param1:*) : void
      {
         ident = param1.ident;
         refillableCooldownId = param1.refillableCooldownId;
         refillableBattleId = param1.refillableBattleId;
      }
   }
}
