package game.command.rpc.player.server
{
   import flash.utils.Dictionary;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   
   public class CommandServerGetAll extends RPCCommandBase
   {
       
      
      private var _servers:Vector.<ServerListValueObject>;
      
      private var _maxServer:int;
      
      public function CommandServerGetAll()
      {
         super();
         rpcRequest = new RpcRequest("serverGetAll");
         rpcRequest.writeRequest(new RpcRequest("userMaxMigrateServer"));
      }
      
      public function get servers() : Vector.<ServerListValueObject>
      {
         return _servers;
      }
      
      public function get maxServer() : int
      {
         return _maxServer;
      }
      
      override protected function successHandler() : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc8_:Dictionary = new Dictionary();
         _servers = new Vector.<ServerListValueObject>();
         var _loc5_:Array = result.body.servers || [];
         var _loc2_:int = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = new ServerListValueObject(_loc5_[_loc6_]);
            _servers.push(_loc4_);
            _loc8_[_loc4_.id] = _loc4_;
            _loc6_++;
         }
         var _loc7_:Array = result.body.users || [];
         _loc2_ = _loc7_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc3_ = new ServerListUserValueObject(_loc7_[_loc6_]);
            _loc1_ = _loc8_[_loc3_.serverId] as ServerListValueObject;
            if(_loc1_)
            {
               _loc1_.user = _loc3_;
            }
            _loc6_++;
         }
         _maxServer = int(result.data.userMaxMigrateServer);
         super.successHandler();
      }
   }
}
