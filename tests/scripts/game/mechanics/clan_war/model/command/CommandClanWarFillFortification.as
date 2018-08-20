package game.mechanics.clan_war.model.command
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.model.ClanWarPlanSlotValueObject;
   
   public class CommandClanWarFillFortification extends RPCCommandBase
   {
       
      
      private var _slot:ClanWarPlanSlotValueObject;
      
      private var _defender:ClanWarDefenderValueObject;
      
      public function CommandClanWarFillFortification(param1:ClanWarPlanSlotValueObject, param2:ClanWarDefenderValueObject)
      {
         super();
         this._defender = param2;
         this._slot = param1;
         rpcRequest = new RpcRequest("clanWarFillFortification");
         rpcRequest.critialError = false;
         var _loc3_:Object = {};
         _loc3_[param1.id] = !!param2?param2.userId:null;
         rpcRequest.writeParam("slots",_loc3_);
      }
      
      public function get slot() : ClanWarPlanSlotValueObject
      {
         return _slot;
      }
      
      public function get defender() : ClanWarDefenderValueObject
      {
         return _defender;
      }
      
      public function get isSuccessful() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Object = result.body.result;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for(var _loc3_ in _loc2_)
         {
            _loc1_ = _loc2_[_loc3_];
         }
         return _loc1_;
      }
   }
}
