package game.command.rpc.grand
{
   import battle.BattleConfig;
   import engine.context.GameContext;
   import game.battle.controller.thread.BattleThread;
   import game.command.rpc.RpcRequest;
   import game.command.rpc.mission.CommandBattleStartReplay;
   import game.mechanics.grand.mediator.GrandBattleThread;
   import game.mediator.gui.popup.PopupList;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   
   public class CommandGrandReplayPack extends CommandBattleStartReplay
   {
       
      
      private var ids:Vector.<String>;
      
      public function CommandGrandReplayPack(param1:Vector.<String>, param2:int = 0, param3:String = null)
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         super(param1[0],param2,param3);
         this.ids = param1;
         var _loc6_:int = param1.length;
         _loc4_ = 1;
         while(_loc4_ < _loc6_)
         {
            _loc5_ = new RpcRequest("battleGetReplay");
            _loc5_.writeParam("id",param1[_loc4_]);
            this.rpcRequest.writeRequest(_loc5_,"battleGetReplay" + _loc4_);
            _loc4_++;
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc2_:int = 0;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc12_:* = null;
         if(!result.body)
         {
            if(GameContext.instance.consoleEnabled)
            {
               PopupList.instance.message("Реплей с заданным id не найден");
            }
            signal_replayComplete.dispatch(new BattleThread(new BattleConfig()));
            signal_replayComplete.removeAll();
            return;
         }
         signal_replayStart.dispatch();
         signal_replayStart.removeAll();
         var _loc4_:Array = [result.body.replay];
         var _loc11_:Object = result.body.users;
         if(explicitBattleVersion != 0)
         {
            _loc4_[0].result.serverVersion = explicitBattleVersion;
         }
         var _loc9_:int = ids.length;
         _loc2_ = 1;
         while(_loc2_ < _loc9_)
         {
            _loc6_ = result.data["battleGetReplay" + _loc2_].replay;
            _loc4_.push(_loc6_);
            if(explicitBattleVersion != 0)
            {
               _loc6_.result.serverVersion = explicitBattleVersion;
            }
            _loc2_++;
         }
         var _loc7_:String = _loc6_.type;
         if(explicitBattleType)
         {
            _loc7_ = explicitBattleType;
         }
         var _loc10_:Object = _loc11_[_loc6_.userId];
         var _loc5_:Object = _loc11_[_loc6_.typeId];
         if(_loc10_ && _loc11_)
         {
            _loc3_ = new UserInfo();
            _loc3_.parse(_loc10_);
         }
         if(_loc5_ && _loc11_)
         {
            _loc12_ = new UserInfo();
            _loc12_.parse(_loc5_);
         }
         var _loc8_:GrandBattleThread = new GrandBattleThread(param1,new GrandBattleResult(param1,_loc3_,_loc12_,_loc4_));
         _loc8_.run();
      }
   }
}
