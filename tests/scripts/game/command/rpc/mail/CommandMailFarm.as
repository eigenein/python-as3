package game.command.rpc.mail
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.mail.MailRewardValueObjectList;
   import game.model.user.Player;
   import game.model.user.mail.PlayerMailEntry;
   
   public class CommandMailFarm extends CostCommand
   {
       
      
      private var letters:Vector.<PlayerMailEntry>;
      
      private var _rewardList:MailRewardValueObjectList;
      
      public function CommandMailFarm(param1:Vector.<PlayerMailEntry>)
      {
         var _loc3_:int = 0;
         super();
         this.letters = param1;
         rpcRequest = new RpcRequest("mailFarm");
         var _loc4_:Array = [];
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_[_loc3_] = param1[_loc3_].id;
            _loc3_++;
         }
         rpcRequest.writeParam("letterIds",_loc4_);
      }
      
      public function get rewardList() : MailRewardValueObjectList
      {
         return _rewardList;
      }
      
      override public function clientExecute(param1:Player) : void
      {
         super.clientExecute(param1);
         param1.mail.farmLetters(letters);
      }
      
      override protected function successHandler() : void
      {
         var _loc1_:* = null;
         _reward = new RewardData();
         var _loc3_:Object = result.body;
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for(var _loc2_ in _loc3_)
         {
            _loc1_ = _loc3_[_loc2_];
            _reward.add(new RewardData(_loc1_));
         }
         _rewardList = new MailRewardValueObjectList(result.body,letters);
         super.successHandler();
      }
   }
}
