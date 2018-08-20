package game.command.rpc.login
{
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import engine.context.GameContext;
   import engine.context.platform.PlatformUser;
   import engine.context.platform.social.FBSocialFacadeHelper;
   import game.command.rpc.CommandResultError;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.model.GameModel;
   
   public class CommandSocialClientInit extends RPCCommandBase
   {
       
      
      public function CommandSocialClientInit(param1:GameContext)
      {
         var _loc2_:* = null;
         super();
         rpcRequest = new RpcRequest("registration");
         if(param1.platformFacade.referrer.gift_id)
         {
            _loc2_ = new RpcRequest("freebieCheck");
            _loc2_.writeParam("giftId",param1.platformFacade.referrer.gift_id);
            rpcRequest.writeRequest(_loc2_);
         }
         new LoginRPCRequest(rpcRequest);
         var _loc6_:PlatformUser = param1.platformFacade.user;
         var _loc3_:Date = new Date();
         var _loc7_:String = null;
         if(GameModel.instance.context.platformFacade.network == "facebook")
         {
            _loc7_ = FBSocialFacadeHelper.email;
         }
         var _loc4_:int = -_loc3_.timezoneOffset / 60;
         var _loc5_:Object = {
            "sex":(!!_loc6_.male?"male":"female"),
            "email":_loc7_,
            "firstName":correctUserName(_loc6_.firstName),
            "lastName":correctUserName(_loc6_.lastName),
            "birthday":_loc6_.birthDate,
            "photoUrl":_loc6_.photoURL,
            "referrer":param1.platformFacade.referrer.serializedObjectForRPCInit,
            "locale":GameContext.instance.localeID,
            "timeZone":_loc4_
         };
         rpcRequest.writeParam("user",_loc5_);
      }
      
      private function correctUserName(param1:String) : String
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:uint = 0;
         var _loc6_:int = 2147483647;
         if(GameContext.instance.libStaticData)
         {
            _loc4_ = GameContext.instance.libStaticData.rule.nicknameUpdate.minLength;
            _loc6_ = GameContext.instance.libStaticData.rule.nicknameUpdate.maxLength;
         }
         if(param1.length > _loc6_)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_ && _loc2_.length)
            {
               _loc3_ = "";
               _loc5_ = 0;
               while(_loc5_ < _loc2_.length)
               {
                  _loc3_ = _loc3_ + _loc2_[_loc5_];
                  if(_loc3_.length >= _loc4_)
                  {
                     break;
                  }
                  _loc5_++;
               }
               return _loc3_.substr(0,_loc6_);
            }
         }
         return param1;
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         error = new CommandResultError();
         error.message = param1.response.body.error.name + " " + param1.response.body.error.description;
         signal_error.dispatch(this);
      }
   }
}
