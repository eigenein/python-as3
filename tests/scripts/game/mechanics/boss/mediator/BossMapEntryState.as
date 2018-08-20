package game.mechanics.boss.mediator
{
   public class BossMapEntryState
   {
      
      public static const OPEN:BossMapEntryState = new BossMapEntryState("open");
      
      public static const CHEST:BossMapEntryState = new BossMapEntryState("chest");
      
      public static const BOSS:BossMapEntryState = new BossMapEntryState("boss");
      
      public static const BOSS_NEXT:BossMapEntryState = new BossMapEntryState("bossNext");
      
      public static const FUTURE:BossMapEntryState = new BossMapEntryState("future");
       
      
      private var name:String;
      
      public function BossMapEntryState(param1:String)
      {
         super();
         this.name = param1;
      }
      
      public static function fromId(param1:int) : BossMapEntryState
      {
         if(param1 == 1)
         {
            return BOSS;
         }
         return CHEST;
      }
   }
}
