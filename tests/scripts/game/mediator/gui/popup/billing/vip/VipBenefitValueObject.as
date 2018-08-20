package game.mediator.gui.popup.billing.vip
{
   public class VipBenefitValueObject
   {
       
      
      private var _text:String;
      
      public function VipBenefitValueObject(param1:String)
      {
         super();
         _text = param1;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}
