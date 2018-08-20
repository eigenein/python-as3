package game.view.specialoffer.costreplacetownchestpack
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.refillable.CostButtonWithSale;
   
   public class SpecialOfferCostReplaceTownChestPackButtonClip extends GuiClipNestedContainer
   {
       
      
      public var cost_button_pack:CostButtonWithSale;
      
      public var tf_sale_old:ClipLabel;
      
      public var tf_sale:SpecialClipLabel;
      
      public function SpecialOfferCostReplaceTownChestPackButtonClip()
      {
         cost_button_pack = new CostButtonWithSale();
         tf_sale_old = new ClipLabel();
         tf_sale = new SpecialClipLabel();
         super();
      }
   }
}
