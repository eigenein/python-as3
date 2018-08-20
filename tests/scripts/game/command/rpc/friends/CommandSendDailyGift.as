package game.command.rpc.friends
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.user.Player;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class CommandSendDailyGift extends RPCCommandBase
   {
       
      
      private var _friends:Vector.<PlayerFriendEntry>;
      
      public function CommandSendDailyGift(param1:Vector.<PlayerFriendEntry>, param2:Vector.<String>)
      {
         var _loc5_:int = 0;
         super();
         this._friends = param1;
         var _loc4_:Array = [];
         var _loc3_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = param1[_loc5_].id;
            _loc5_++;
         }
         rpcRequest = new RpcRequest("friendsSendDailyGift");
         rpcRequest.writeParam("ids",_loc4_);
         _loc4_ = [];
         if(param2)
         {
            _loc3_ = param2.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_.push(param2[_loc5_]);
               _loc5_++;
            }
         }
         rpcRequest.writeParam("notifiedUserIds",_loc4_);
      }
      
      public function get friends() : Vector.<PlayerFriendEntry>
      {
         return _friends;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.friends.onDailyGiftSent(_friends);
         super.clientExecute(param1);
      }
   }
}
