package game.command.rpc.mail
{
   import game.data.reward.RewardData;
   import game.mediator.gui.component.RewardValueObject;
   import game.model.user.mail.PlayerMailEntry;
   
   public class MailRewardValueObject extends RewardValueObject
   {
       
      
      private var _letter:PlayerMailEntry;
      
      private var _deleted:Boolean;
      
      public function MailRewardValueObject(param1:RewardData, param2:PlayerMailEntry, param3:Boolean)
      {
         super(param1);
         this._letter = param2;
         this._deleted = param3;
      }
      
      public function get letter() : PlayerMailEntry
      {
         return _letter;
      }
      
      public function get deleted() : Boolean
      {
         return _deleted;
      }
   }
}
