package game.command.rpc.quest
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.Player;
   import game.model.user.quest.PlayerQuestEntry;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandQuestFarm extends CostCommand
   {
       
      
      private var _entry:PlayerQuestEntry;
      
      public var stashClick:PopupStashEventParams;
      
      public function CommandQuestFarm(param1:PlayerQuestEntry)
      {
         super();
         this._entry = param1;
         rpcRequest = new RpcRequest("questFarm");
         rpcRequest.writeParam("questId",param1.desc.id);
         _reward = param1.reward;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         param1.questData.questFarm(entry);
         super.clientExecute(param1);
      }
      
      public function get entry() : PlayerQuestEntry
      {
         return _entry;
      }
      
      override public function onRpc_infoHandler(param1:Object) : void
      {
         super.onRpc_infoHandler(param1);
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body);
         super.successHandler();
         Tutorial.events.triggerEvent_farmQuest(entry);
      }
   }
}
