package game.command.rpc.grand
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.storage.hero.UnitDescription;
   import game.model.user.Player;
   
   public class CommandGrandSetHeroes extends RPCCommandBase
   {
       
      
      protected var heroes:Vector.<Vector.<UnitDescription>>;
      
      public function CommandGrandSetHeroes(param1:Vector.<Vector.<UnitDescription>>)
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         super();
         this.heroes = param1;
         rpcRequest = new RpcRequest("grandSetHeroes");
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            var _loc7_:* = [];
            _loc4_[_loc5_] = _loc7_;
            _loc6_ = _loc7_;
            _loc3_ = param1[_loc5_];
            var _loc9_:int = 0;
            var _loc8_:* = _loc3_;
            for each(var _loc2_ in _loc3_)
            {
               _loc6_.push(_loc2_.id);
            }
            _loc5_++;
         }
         rpcRequest.writeParam("heroes",_loc4_);
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(result.body)
         {
            param1.grand.update(result.body);
         }
      }
   }
}
