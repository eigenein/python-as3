package game.command.rpc.rating
{
   import game.model.GameModel;
   
   public class CommandRatingGetResult
   {
       
      
      private var src:Object;
      
      private var ratingType:String;
      
      private var _list:Vector.<CommandRatingTopGetResultEntry>;
      
      private var _playerPlace:CommandRatingTopGetResultEntry;
      
      private var _playerPlaceDelta:int;
      
      public function CommandRatingGetResult(param1:Object, param2:String)
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc10_:* = null;
         var _loc7_:* = null;
         super();
         this.src = param1;
         this.ratingType = param2;
         this._list = new Vector.<CommandRatingTopGetResultEntry>();
         var _loc4_:Array = param1.top;
         var _loc5_:int = _loc4_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc6_ = _loc4_[_loc8_];
            if(_loc6_.userId)
            {
               _loc10_ = param1.users[_loc6_.userId];
               _list.push(createEntry(_loc8_ + 1,_loc6_,_loc10_));
            }
            else if(_loc6_.clanId)
            {
               _loc7_ = null;
               var _loc12_:int = 0;
               var _loc11_:* = param1.clans;
               for each(var _loc9_ in param1.clans)
               {
                  if(_loc9_.id == _loc6_.clanId)
                  {
                     _loc7_ = _loc9_;
                     break;
                  }
               }
               _list.push(createEntry(_loc8_ + 1,_loc6_,_loc7_));
            }
            else
            {
               _list.push(createEntry(_loc8_ + 1,_loc6_,null));
            }
            _loc8_++;
         }
         if(param2 == "clan" || param2 == "clanDungeon" || param2 == "nyTree")
         {
            _playerPlace = createEntry(param1.place,param1,GameModel.instance.player.clan.clan);
         }
         else
         {
            _playerPlace = createEntry(param1.place,param1,GameModel.instance.player.getUserInfo());
         }
         _playerPlaceDelta = param1.delta;
      }
      
      public function get list() : Vector.<CommandRatingTopGetResultEntry>
      {
         return _list;
      }
      
      public function get playerPlace() : CommandRatingTopGetResultEntry
      {
         return _playerPlace;
      }
      
      public function get playerPlaceDelta() : int
      {
         return _playerPlaceDelta;
      }
      
      protected function createEntry(param1:int, param2:Object, param3:Object) : CommandRatingTopGetResultEntry
      {
         var _loc4_:* = ratingType;
         if("arena" !== _loc4_)
         {
            if("grand" !== _loc4_)
            {
               if("power" !== _loc4_)
               {
                  if("titanPower" !== _loc4_)
                  {
                     if("dungeonFloor" !== _loc4_)
                     {
                        if("clan" !== _loc4_)
                        {
                           if("clanDungeon" !== _loc4_)
                           {
                              if("giftsSend" !== _loc4_)
                              {
                                 if("giftsReceived" !== _loc4_)
                                 {
                                    if("nyTree" !== _loc4_)
                                    {
                                       if("quiz" !== _loc4_)
                                       {
                                          if("titanArenaCurrent" !== _loc4_)
                                          {
                                             if("titanArenaPrevious" !== _loc4_)
                                             {
                                                return null;
                                             }
                                             return new CommandRatingTopGetResultTitanArenaEntry(param1,param2,param3);
                                          }
                                          return new CommandRatingTopGetResultTitanArenaEntry(param1,param2,param3);
                                       }
                                       return new CommandRatingTopGetResultQuizPoints(param1,param2,param3);
                                    }
                                    return new CommandRatingTopGetResultNYTreeDecorateActionsEntry(param1,param2,param3);
                                 }
                                 return new CommandRatingTopGetResultGiftsReceivedEntry(param1,param2,param3);
                              }
                              return new CommandRatingTopGetResultGiftsSendEntry(param1,param2,param3);
                           }
                           return new CommandRatingTopGetResultClanDungeonEntry(param1,param2,param3);
                        }
                        return new CommandRatingTopGetResultClanEntry(param1,param2,param3);
                     }
                     return new CommandRatingTopGetResultDungeonFloorEntry(param1,param2,param3);
                  }
                  return new CommandRatingTopGetResultTitanPowerEntry(param1,param2,param3);
               }
               return new CommandRatingTopGetResultPowerEntry(param1,param2,param3);
            }
            return new CommandRatingTopGetResultGrandEntry(param1,param2,param3);
         }
         return new CommandRatingTopGetResultArenaEntry(param1,param2,param3);
      }
   }
}
