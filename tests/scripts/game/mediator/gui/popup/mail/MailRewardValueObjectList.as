package game.mediator.gui.popup.mail
{
   import game.command.rpc.mail.MailRewardValueObject;
   import game.data.reward.RewardData;
   import game.mediator.gui.component.RewardValueObject;
   import game.mediator.gui.component.RewardValueObjectList;
   import game.model.user.mail.PlayerMailEntry;
   
   public class MailRewardValueObjectList extends RewardValueObjectList
   {
       
      
      private var letters:Vector.<PlayerMailEntry>;
      
      private var rawData:Object;
      
      public function MailRewardValueObjectList(param1:Object, param2:Vector.<PlayerMailEntry>)
      {
         this.letters = param2;
         this.rawData = param1;
         var _loc3_:Vector.<RewardData> = new Vector.<RewardData>();
         super(_loc3_);
      }
      
      override protected function createValueObjectList() : void
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc1_:Boolean = false;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         _rewardValueObjectList = new Vector.<RewardValueObject>();
         var _loc10_:int = 0;
         var _loc9_:* = rawData;
         for(var _loc5_ in rawData)
         {
            _loc4_ = rawData[_loc5_];
            if(_loc4_.deleted)
            {
               _loc8_ = new RewardData();
               _loc1_ = true;
            }
            else
            {
               _loc8_ = new RewardData(_loc4_);
               _loc1_ = false;
               _merged.add(_loc8_);
            }
            _loc3_ = null;
            _loc2_ = letters.length;
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               if(letters[_loc6_].id == _loc5_)
               {
                  _loc3_ = letters[_loc6_];
                  break;
               }
               _loc6_++;
            }
            _loc7_ = new MailRewardValueObject(_loc8_,_loc3_,_loc1_);
            _rewardValueObjectList.push(_loc7_);
         }
      }
   }
}
