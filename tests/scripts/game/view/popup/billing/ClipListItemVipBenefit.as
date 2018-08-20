package game.view.popup.billing
{
   import engine.core.clipgui.ClipSprite;
   import game.mediator.gui.popup.billing.vip.VipBenefitValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipListItem;
   
   public class ClipListItemVipBenefit extends ClipListItem
   {
       
      
      public var bullet:ClipSprite;
      
      public var tf_text:ClipLabel;
      
      public function ClipListItemVipBenefit()
      {
         tf_text = new ClipLabel();
         super();
      }
      
      override public function setData(param1:*) : void
      {
         var _loc2_:VipBenefitValueObject = param1 as VipBenefitValueObject;
         if(!_loc2_)
         {
            return;
         }
         tf_text.text = _loc2_.text;
         tf_text.validate();
      }
   }
}
