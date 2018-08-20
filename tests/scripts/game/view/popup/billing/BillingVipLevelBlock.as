package game.view.popup.billing
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class BillingVipLevelBlock extends GuiClipNestedContainer
   {
       
      
      public var vip_word:ClipSprite;
      
      public var vip_first_digit:ClipSprite;
      
      public var vip_second_digit:ClipSprite;
      
      public function BillingVipLevelBlock()
      {
         super();
      }
      
      public function setVip(param1:int) : void
      {
         if(param1 > 9)
         {
            if(!vip_first_digit.graphics.parent)
            {
               container.addChild(vip_first_digit.graphics);
            }
            if(!vip_second_digit.graphics.parent)
            {
               container.addChild(vip_second_digit.graphics);
            }
            vip_second_digit.setFrame(param1 % 10);
            vip_first_digit.setFrame(int(param1 / 10));
         }
         else if(param1 > 0)
         {
            if(!vip_first_digit.graphics.parent)
            {
               container.addChild(vip_first_digit.graphics);
            }
            if(vip_second_digit.graphics.parent)
            {
               container.removeChild(vip_second_digit.graphics);
            }
            vip_first_digit.setFrame(param1 % 10);
            vip_second_digit.setFrame(10);
         }
         else
         {
            if(vip_first_digit.graphics.parent)
            {
               container.removeChild(vip_first_digit.graphics);
            }
            if(vip_second_digit.graphics.parent)
            {
               container.removeChild(vip_second_digit.graphics);
            }
         }
      }
   }
}
