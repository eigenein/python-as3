package game.command.social
{
   import game.data.reward.RewardData;
   
   public class SocialBillingBuyResult
   {
       
      
      private var _reward:RewardData;
      
      private var _newStarmoneyValue:int;
      
      private var _transactionId:String;
      
      private var _specialOffers:Array;
      
      public function SocialBillingBuyResult(param1:Object, param2:int, param3:String, param4:Array)
      {
         super();
         _reward = new RewardData(param1);
         _newStarmoneyValue = param2;
         _transactionId = param3;
         _specialOffers = param4;
      }
      
      public function get reward() : RewardData
      {
         return _reward;
      }
      
      public function get newStarmoneyValue() : int
      {
         return _newStarmoneyValue;
      }
      
      public function get transactionId() : String
      {
         return _transactionId;
      }
      
      public function get specialOffers() : Array
      {
         return _specialOffers;
      }
      
      public function getSummaryReward(param1:int) : RewardData
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getOfferReward(param1:int) : RewardData
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
