package game.command.rpc.dailybonus
{
   import game.command.requirement.CommandRequirement;
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.dailybonus.DailyBonusDescription;
   import game.mediator.gui.popup.dailybonus.DailyBonusValueObject;
   import game.model.user.Player;
   
   public class CommandDailyBonusFarm extends CostCommand
   {
      
      public static const FARM_NORMAL:int = 0;
      
      public static const FARM_NORMAL_AND_VIP:int = 1;
      
      public static const FARM_VIP_ONLY:int = 2;
       
      
      private var farmType:int;
      
      private var _vo:DailyBonusValueObject;
      
      public function CommandDailyBonusFarm(param1:int, param2:DailyBonusValueObject)
      {
         super();
         this._vo = param2;
         this.farmType = param1;
         rpcRequest = new RpcRequest("dailyBonusFarm");
         rpcRequest.writeParam("vip",param1);
      }
      
      override public function prerequisiteCheck(param1:Player) : CommandRequirement
      {
         var _loc2_:int = 0;
         var _loc4_:CommandRequirement = super.prerequisiteCheck(param1);
         var _loc3_:Boolean = false;
         var _loc5_:DailyBonusDescription = DataStorage.dailyBonus.getByDay(param1.dailyBonus.day);
         if(!_loc5_)
         {
            _loc4_.invalid = true;
         }
         else
         {
            _loc2_ = _loc5_.vipLevelDouble;
            if(farmType == 0)
            {
               _loc3_ = param1.dailyBonus.availableSingle;
            }
            if(farmType == 1)
            {
               _loc3_ = param1.dailyBonus.availableSingle && param1.dailyBonus.availableDouble;
               _loc4_.vipLevel = _loc2_;
            }
            if(farmType == 2)
            {
               _loc3_ = param1.dailyBonus.availableDouble;
               _loc4_.vipLevel = _loc2_;
            }
            if(!_loc3_)
            {
               _loc4_.invalid = true;
            }
         }
         return _loc4_;
      }
      
      override protected function successHandler() : void
      {
         _reward = new RewardData(result.body);
         super.successHandler();
      }
      
      override public function clientExecute(param1:Player) : void
      {
         if(farmType == 0)
         {
            param1.dailyBonus.farmNormal();
         }
         if(farmType == 1)
         {
            param1.dailyBonus.farmNormal();
            param1.dailyBonus.farmVip();
         }
         if(farmType == 2)
         {
            param1.dailyBonus.farmVip();
         }
         super.clientExecute(param1);
      }
      
      public function get vo() : DailyBonusValueObject
      {
         return _vo;
      }
   }
}
