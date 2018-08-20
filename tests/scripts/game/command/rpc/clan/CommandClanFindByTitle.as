package game.command.rpc.clan
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.clan.value.ClanPublicInfoValueObject;
   
   public class CommandClanFindByTitle extends RPCCommandBase
   {
       
      
      private var _searchResult:Vector.<ClanPublicInfoValueObject>;
      
      public function CommandClanFindByTitle(param1:String)
      {
         super();
         rpcRequest = new RpcRequest("clanFindByTitle");
         rpcRequest.writeParam("title",param1);
      }
      
      public function get searchResult() : Vector.<ClanPublicInfoValueObject>
      {
         return _searchResult;
      }
      
      override protected function successHandler() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = result.data.body;
         _searchResult = new Vector.<ClanPublicInfoValueObject>();
         var _loc1_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = new ClanPublicInfoValueObject({"clan":_loc2_[_loc4_]});
            _searchResult[_loc4_] = _loc3_;
            _loc4_++;
         }
         super.successHandler();
      }
   }
}
