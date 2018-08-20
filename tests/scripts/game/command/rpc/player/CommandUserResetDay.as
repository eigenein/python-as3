package game.command.rpc.player
{
   import com.progrestar.common.Logger;
   import com.progrestar.common.new_rpc.RpcEntryBase;
   import engine.context.GameContext;
   import flash.events.Event;
   import flash.utils.Timer;
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.command.timer.GameTimer;
   import game.data.storage.mechanic.MechanicStorage;
   import game.model.user.Player;
   
   public class CommandUserResetDay extends RPCCommandBase
   {
       
      
      private var reloadTimer:Timer;
      
      public function CommandUserResetDay(param1:int)
      {
         super();
         rpcRequest = new RpcRequest("userGetInfo");
         rpcRequest.writeRequest(new RpcRequest("dailyBonusGetInfo"));
         rpcRequest.writeRequest(new RpcRequest("questGetAll"));
         rpcRequest.writeRequest(new RpcRequest("getTime"));
         rpcRequest.writeRequest(new RpcRequest("mailGetAll"));
         rpcRequest.writeRequest(new RpcRequest("towerGetInfo"));
         rpcRequest.writeRequest(new RpcRequest("offerGetAll"));
         if(param1 >= MechanicStorage.CLAN_DUNGEON.teamLevel)
         {
            rpcRequest.writeRequest(new RpcRequest("dungeonGetInfo"));
         }
      }
      
      private function get userGetInfo() : *
      {
         return result.body;
      }
      
      private function get dailyBonusGetInfo() : *
      {
         return result.data["dailyBonusGetInfo"];
      }
      
      private function get questGetAll() : *
      {
         return result.data["questGetAll"];
      }
      
      private function get mailGetAll() : *
      {
         return result.data["mailGetAll"];
      }
      
      private function get towerGetInfo() : *
      {
         return result.data["towerGetInfo"];
      }
      
      private function get dungeonGetInfo() : *
      {
         return result.data["dungeonGetInfo"];
      }
      
      private function get offerGetAll() : *
      {
         return result.data["offerGetAll"];
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.refillable.reset(userGetInfo.refillable);
         param1.missions.reset();
         param1.dailyBonus.init(dailyBonusGetInfo);
         param1.questData.reset(questGetAll);
         param1.mail.update(mailGetAll);
         param1.tower.reset(towerGetInfo);
         if(dungeonGetInfo)
         {
            param1.dungeon.reset(dungeonGetInfo);
         }
         param1.specialOffer.reset(offerGetAll);
      }
      
      override public function onRpc_errorHandler(param1:RpcEntryBase) : void
      {
         var _loc2_:int = GameTimer.instance.currentServerTime - (GameTimer.instance.nextDayTimestamp - 86400);
         Logger.getLogger("CommandUserResetDay").error("error:" + JSON.stringify(param1.response.error),"timeFromLogin:" + GameTimer.instance.timeFromLogin,"timeFromLoginGetTimer:" + GameTimer.instance.timeFromLoginGetTimer,"timeFromReset:" + _loc2_);
         reloadTimer = new Timer(500,1);
         reloadTimer.addEventListener("timer",handler_reloadTimer);
         reloadTimer.start();
      }
      
      private function handler_reloadTimer(param1:Event) : void
      {
         GameContext.instance.reloadGame();
      }
   }
}
