package game.view.popup.refillable
{
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class StaminaRefillPopupClip extends RefillPopupClipBase
   {
       
      
      public var tf_energy:ClipLabel;
      
      public var icon:ClipSprite;
      
      public var layout_header:ClipLayout;
      
      public var use_energy_item_block:StaminaUseEnergyItemBlockClip;
      
      public function StaminaRefillPopupClip()
      {
         tf_energy = new ClipLabel(true);
         icon = new ClipSprite();
         layout_header = ClipLayout.horizontalMiddleCentered(4);
         use_energy_item_block = new StaminaUseEnergyItemBlockClip();
         super();
         layout_header.addChild(tf_label_buy);
         layout_header.addChild(icon.graphics);
         layout_header.addChild(tf_energy);
      }
   }
}
