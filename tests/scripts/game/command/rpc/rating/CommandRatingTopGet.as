package game.command.rpc.rating
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandRatingTopGet extends RPCCommandBase
   {
      
      public static const RATING_TYPE_POWER:String = "power";
      
      public static const RATING_TYPE_ARENA:String = "arena";
      
      public static const RATING_TYPE_GRAND:String = "grand";
      
      public static const RATING_TYPE_CLAN:String = "clan";
      
      public static const RATING_TYPE_TITAN_POWER:String = "titanPower";
      
      public static const RATING_TYPE_CLAN_DUNGEON:String = "clanDungeon";
      
      public static const RATING_TYPE_DUNGEON_FLOOR:String = "dungeonFloor";
      
      public static const RATING_TYPE_GIFTS_SEND:String = "giftsSend";
      
      public static const RATING_TYPE_GIFTS_RECEIVED:String = "giftsReceived";
      
      public static const RATING_TYPE_NY_TREE:String = "nyTree";
      
      public static const RATING_TYPE_QUIZ:String = "quiz";
      
      public static const RATING_TYPE_TITAN_ARENA_CURRENT:String = "titanArenaCurrent";
      
      public static const RATING_TYPE_TITAN_ARENA_PREVIOS:String = "titanArenaPrevious";
       
      
      private var _ratingType:String;
      
      private var _resultValueObject:CommandRatingGetResult;
      
      public function CommandRatingTopGet(param1:String)
      {
         super();
         _ratingType = param1;
         rpcRequest = new RpcRequest("topGet");
         rpcRequest.writeParam("type",param1);
      }
      
      public function get ratingType() : String
      {
         return _ratingType;
      }
      
      public function get resultValueObject() : CommandRatingGetResult
      {
         return _resultValueObject;
      }
      
      override protected function successHandler() : void
      {
         _resultValueObject = new CommandRatingGetResult(result.body,_ratingType);
         super.successHandler();
      }
   }
}
