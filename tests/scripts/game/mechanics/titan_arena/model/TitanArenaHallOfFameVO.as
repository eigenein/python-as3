package game.mechanics.titan_arena.model
{
   public class TitanArenaHallOfFameVO
   {
       
      
      public var myCup:uint;
      
      public var myPlace:uint;
      
      public var key:Number;
      
      public var prev:Number;
      
      public var next:Number;
      
      public var bestOnServer:TitanArenaHallOfFameUserInfo;
      
      public var champions:Vector.<TitanArenaHallOfFameUserInfo>;
      
      public var bestGuildMembers:Vector.<TitanArenaHallOfFameUserInfo>;
      
      public function TitanArenaHallOfFameVO(param1:Object)
      {
         var _loc2_:* = null;
         champions = new Vector.<TitanArenaHallOfFameUserInfo>();
         bestGuildMembers = new Vector.<TitanArenaHallOfFameUserInfo>();
         super();
         this.key = param1.key;
         this.prev = param1.prev;
         this.next = param1.next;
         if(param1.result)
         {
            this.myCup = param1.result.cup;
            this.myPlace = param1.result.place;
         }
         champions.length = 0;
         if(param1.champions)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1.champions;
            for each(var _loc3_ in param1.champions)
            {
               _loc2_ = new TitanArenaHallOfFameUserInfo();
               _loc2_.parse(_loc3_);
               champions.push(_loc2_);
            }
         }
         bestGuildMembers.length = 0;
         if(param1.bestGuildMembers)
         {
            var _loc7_:int = 0;
            var _loc6_:* = param1.bestGuildMembers;
            for each(_loc3_ in param1.bestGuildMembers)
            {
               _loc2_ = new TitanArenaHallOfFameUserInfo();
               _loc2_.parse(_loc3_);
               bestGuildMembers.push(_loc2_);
            }
            bestGuildMembers.sort(sortUserInfoByPlace);
         }
         if(param1.bestOnServer)
         {
            bestOnServer = new TitanArenaHallOfFameUserInfo();
            bestOnServer.parse(param1.bestOnServer);
         }
         else
         {
            bestOnServer = null;
         }
      }
      
      private function sortUserInfoByPlace(param1:TitanArenaHallOfFameUserInfo, param2:TitanArenaHallOfFameUserInfo) : int
      {
         return param1.place - param2.place;
      }
   }
}
