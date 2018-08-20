package game.view.popup.refillable
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.billing.BillingVipLevelBlock;
   
   public class RefillNeedVIPBlock extends GuiClipNestedContainer
   {
       
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_message:ClipLabel;
      
      public var next_vip_level:BillingVipLevelBlock;
      
      public function RefillNeedVIPBlock()
      {
         button_ok = new ClipButtonLabeled();
         tf_message = new ClipLabel();
         next_vip_level = new BillingVipLevelBlock();
         super();
      }
   }
}
