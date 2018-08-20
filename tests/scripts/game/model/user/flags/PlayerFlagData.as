package game.model.user.flags
{
   public class PlayerFlagData
   {
      
      public static const FLAG_HAS_REFERRER:int = 1;
      
      public static const FLAG_CHAT_MODERATOR:int = 2;
      
      public static const FLAG_NICKNAME_SET:int = 4;
       
      
      private var flags:int;
      
      public function PlayerFlagData()
      {
         super();
      }
      
      public function init(param1:int) : void
      {
         flags = param1;
      }
      
      public function getFlag(param1:int) : Boolean
      {
         return Boolean(flags & param1);
      }
      
      public function setFlag(param1:int, param2:Boolean) : void
      {
         if(param2)
         {
            flags = flags | param1;
         }
         else
         {
            flags = flags & ~param1;
         }
      }
   }
}
