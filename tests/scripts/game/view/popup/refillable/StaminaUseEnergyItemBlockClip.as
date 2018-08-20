package game.view.popup.refillable
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class StaminaUseEnergyItemBlockClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_energy:ClipLabel;
      
      public var button_use:ClipButtonLabeled;
      
      public var item:InventoryItemRenderer;
      
      public function StaminaUseEnergyItemBlockClip()
      {
         tf_title = new ClipLabel();
         tf_energy = new ClipLabel();
         button_use = new ClipButtonLabeled();
         item = new InventoryItemRenderer();
         super();
      }
   }
}
