package game.mediator.gui.popup.billing
{
   public class BillingBenefitValueObject
   {
       
      
      private var _showGemIcon:Boolean;
      
      private var _value:String;
      
      private var _text:String;
      
      private var _showVip:int;
      
      private var _ending:String;
      
      public function BillingBenefitValueObject(param1:Boolean, param2:String, param3:String, param4:int = -1, param5:String = null)
      {
         super();
         _showGemIcon = param1;
         _value = param2;
         _text = param3;
         _showVip = param4;
         _ending = param5;
      }
      
      public function get showGemIcon() : Boolean
      {
         return _showGemIcon;
      }
      
      public function get showVip() : Boolean
      {
         return _showVip != -1 || _ending != null;
      }
      
      public function get showEnding() : Boolean
      {
         return _ending;
      }
      
      public function get value() : String
      {
         return _value;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get ending() : String
      {
         return _ending;
      }
      
      public function get vipLevel() : int
      {
         return _showVip;
      }
   }
}
