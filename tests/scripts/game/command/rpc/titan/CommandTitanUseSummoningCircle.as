package game.command.rpc.titan
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.clan.ClanSummoningCircleDescription;
   import game.mediator.gui.popup.HeroRewardPopupHandler;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.view.gui.tutorial.Tutorial;
   
   public class CommandTitanUseSummoningCircle extends CostCommand
   {
       
      
      private var _paid:Boolean;
      
      private var _amount:uint;
      
      private var _dungeonActivity:uint;
      
      private var _rewardList:Vector.<RewardData>;
      
      public function CommandTitanUseSummoningCircle(param1:Boolean, param2:uint)
      {
         super();
         _paid = param1;
         _amount = param2;
         var _loc3_:ClanSummoningCircleDescription = DataStorage.clanSummoningCircle.defaultCircle;
         rpcRequest = new RpcRequest("titanUseSummonCircle");
         rpcRequest.writeParam("circleId",_loc3_.id);
         rpcRequest.writeParam("paid",param1);
         rpcRequest.writeParam("amount",param2);
         _cost = new CostData();
         if(paid)
         {
            if(param2 == 1)
            {
               _cost.add(_loc3_.getCostPack(GameModel.instance.player));
            }
            else
            {
               _cost.add(_loc3_.getCostPackX10(GameModel.instance.player));
            }
         }
         else
         {
            _cost.add(_loc3_.getCostSingle(GameModel.instance.player));
            _cost.multiply(param2);
         }
         if(paid && param2 == 10)
         {
            HeroRewardPopupHandler.instance.removeListenerTakeReward();
         }
      }
      
      public function get paid() : Boolean
      {
         return _paid;
      }
      
      public function get amount() : uint
      {
         return _amount;
      }
      
      public function get dungeonActivity() : uint
      {
         return _dungeonActivity;
      }
      
      public function get rewardList() : Vector.<RewardData>
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         if(_paid)
         {
            Tutorial.events.triggerEvent_summoningCirclePack();
         }
         else
         {
            Tutorial.events.triggerEvent_summoningCircleOne();
         }
         param1.titanSummoningCircle.update(result.body);
         if(paid && amount == 10)
         {
            HeroRewardPopupHandler.instance.addListenerTakeReward();
         }
      }
      
      override protected function successHandler() : void
      {
         var _loc2_:int = 0;
         GameModel.instance.player.clan.clan.updateDungeonActivityOnly(this.result.body.dungeonActivity);
         _dungeonActivity = this.result.body.dungeonActivity;
         _reward = new RewardData(null);
         _rewardList = new Vector.<RewardData>();
         var _loc1_:Array = this.result.body.rewards as Array;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _rewardList[_loc2_] = new RewardData(_loc1_[_loc2_]);
            reward.addRawData(_loc1_[_loc2_]);
            _loc2_++;
         }
         super.successHandler();
      }
   }
}
