package game.command.rpc.tutorial
{
   import game.command.rpc.RPCCommandBase;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialTask;
   
   public class CommandTutorialSaveProgress extends RPCCommandBase
   {
       
      
      private var _tasks:Vector.<TutorialTask>;
      
      public function CommandTutorialSaveProgress(param1:Vector.<TutorialTask>)
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         super();
         _tasks = param1.concat();
         var _loc4_:int = _tasks.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = new RpcRequest("tutorialSaveProgress");
            _loc3_.writeParam("taskId",_tasks[_loc2_].description.id);
            if(this.rpcRequest == null)
            {
               this.rpcRequest = _loc3_;
            }
            else
            {
               this.rpcRequest.writeRequest(_loc3_,"tutorialSaveProgress" + _loc2_);
            }
            _loc2_++;
         }
      }
      
      override public function clientExecute(param1:Player) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc2_:* = undefined;
         var _loc3_:* = null;
         Tutorial.events.triggerEvent_tutorialProgressSaved();
         super.clientExecute(param1);
         var _loc6_:int = _tasks.length;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = _tasks[_loc5_];
            Tutorial.__print("progress saved",_loc4_.chain.descirption.id + ":" + _loc4_.description.id);
            if(_loc5_ == 0)
            {
               _loc7_ = result.body;
            }
            else
            {
               _loc7_ = result.data["tutorialSaveProgress" + _loc5_];
            }
            _loc2_ = _loc7_;
            if(_loc2_ != true && _loc2_ != null)
            {
               _loc3_ = new RewardData(_loc2_);
               _loc4_.setReward(_loc3_);
               param1.takeReward(_loc3_);
               Tutorial.events.triggerEvent_tutorialRewardClaimed();
            }
            _loc5_++;
         }
      }
   }
}
