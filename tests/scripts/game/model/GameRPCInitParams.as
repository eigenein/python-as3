package game.model
{
   import com.progrestar.common.new_rpc.RPCClientInitializerParams;
   import com.progrestar.common.util.StrPad;
   import engine.context.GameContext;
   import flash.net.SharedObject;
   
   public class GameRPCInitParams extends RPCClientInitializerParams
   {
       
      
      public function GameRPCInitParams(param1:GameContext)
      {
         super();
         url = param1.rpcURL;
         application_id = param1.platformFacade.app_id;
         auth_key = param1.platformFacade.auth_key;
         network_ident = param1.platformFacade.network;
         user_id = param1.platformFacade.userId;
         if(param1.platformFacade.referrer != null)
         {
            referrer_type = param1.platformFacade.referrer.type;
         }
         client_session_key = createSessionKey();
         network_session_key = param1.platformFacade.session_key;
         player_id = readPlayerId();
      }
      
      override public function readPlayerId() : String
      {
         var _loc1_:SharedObject = SharedObject.getLocal("GameRPCInitParams");
         return _loc1_.data.player_id;
      }
      
      override public function writePlayerId(param1:String) : void
      {
         var _loc2_:* = null;
         if(this.player_id != param1)
         {
            _loc2_ = SharedObject.getLocal("GameRPCInitParams");
            var _loc3_:* = param1;
            _loc2_.data.player_id = _loc3_;
            this.player_id = _loc3_;
         }
      }
      
      private function createSessionKey() : String
      {
         var _loc5_:* = null;
         var _loc3_:* = Math.floor(new Date().getTime() / 1000) & 2147483647;
         var _loc2_:int = Math.random() * 2147483647;
         var _loc4_:String = _loc3_.toString(36);
         var _loc1_:String = _loc2_.toString(36);
         _loc5_ = StrPad.strPad(_loc4_,7,"0") + StrPad.strPad(_loc1_,7,"0");
         return _loc5_;
      }
   }
}
