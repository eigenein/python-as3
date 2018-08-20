package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   import game.model.GameModel;
   import game.model.user.friends.PlayerFriendEntry;
   
   public class CommandClanGetRecommended extends RPCCommandBase
   {
       
      
      private var _result_friendClans:Vector.<ClanPublicInfoValueObject>;
      
      private var _result_recommended:Vector.<ClanPublicInfoValueObject>;
      
      public function CommandClanGetRecommended(param1:int)
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         super();
         rpcRequest = new RpcRequest("clanFind");
         rpcRequest.writeParam("active",false);
         var _loc6_:Array = [];
         var _loc5_:Vector.<PlayerFriendEntry> = GameModel.instance.player.friends.getAppFriends();
         var _loc3_:int = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc5_[_loc4_].serverUserClanId && _loc5_[_loc4_].serverId == param1)
            {
               if(_loc6_.indexOf(_loc5_[_loc4_].serverUserClanId) == -1)
               {
                  _loc6_.push(_loc5_[_loc4_].serverUserClanId);
               }
            }
            _loc4_++;
         }
         if(_loc6_.length)
         {
            _loc2_ = new RpcRequest("clanGetInfoByIds");
            _loc2_.writeParam("ids",_loc6_);
            rpcRequest.writeRequest(_loc2_);
         }
      }
      
      public function get result_friendClans() : Vector.<ClanPublicInfoValueObject>
      {
         return _result_friendClans;
      }
      
      public function get result_recommended() : Vector.<ClanPublicInfoValueObject>
      {
         return _result_recommended;
      }
      
      override protected function successHandler() : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = result.data.body;
         _result_recommended = new Vector.<ClanPublicInfoValueObject>();
         if(_loc2_ && _loc2_.length)
         {
            _loc1_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc3_ = new ClanPublicInfoValueObject({"clan":_loc2_[_loc4_]});
               _result_recommended[_loc4_] = _loc3_;
               _loc4_++;
            }
         }
         _loc2_ = result.data["clanGetInfoByIds"];
         if(_loc2_ && _loc2_.length)
         {
            _result_friendClans = new Vector.<ClanPublicInfoValueObject>();
            _loc1_ = _loc2_.length;
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc3_ = new ClanPublicInfoValueObject({"clan":_loc2_[_loc4_]});
               _result_friendClans[_loc4_] = _loc3_;
               _loc4_++;
            }
         }
         super.successHandler();
      }
   }
}
