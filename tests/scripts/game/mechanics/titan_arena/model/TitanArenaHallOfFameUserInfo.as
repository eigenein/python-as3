package game.mechanics.titan_arena.model
{
   import game.model.user.UserInfo;
   
   public class TitanArenaHallOfFameUserInfo extends UserInfo
   {
       
      
      public var place:uint;
      
      public var score:uint;
      
      public var power:uint;
      
      public var cup:uint;
      
      public function TitanArenaHallOfFameUserInfo()
      {
         super();
      }
      
      override public function parse(param1:Object) : void
      {
         this.place = param1.place;
         this.score = param1.score;
         this.power = param1.power;
         this.cup = param1.cup;
         if(param1.info)
         {
            param1.info.id = param1.userId;
            param1.info.serverId = param1.serverId;
            param1.info.clanId = param1.clanId;
            super.parse(param1.info);
         }
      }
   }
}
