package game.mechanics.clan_war.mediator
{
   import flash.utils.Dictionary;
   
   public class ClanWarSlotState
   {
      
      private static var dict:Dictionary = new Dictionary();
      
      public static const READY:ClanWarSlotState = new ClanWarSlotState("ready");
      
      public static const IN_BATTLE:ClanWarSlotState = new ClanWarSlotState("inBattle");
      
      public static const DEFEATED:ClanWarSlotState = new ClanWarSlotState("defeated");
      
      public static const EMPTY:ClanWarSlotState = new ClanWarSlotState("empty");
       
      
      private var state:String;
      
      public function ClanWarSlotState(param1:String)
      {
         super();
         this.state = param1;
         dict[param1] = this;
      }
      
      public static function getStatus(param1:String) : ClanWarSlotState
      {
         return dict[param1];
      }
   }
}
