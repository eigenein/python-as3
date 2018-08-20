package game.view.popup.hero.consumable
{
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.hero.HeroListDialogBaseClip;
   import game.view.popup.hero.HeroListDialogPotionIconClip;
   
   public class HeroUseConsumableDialogClip extends HeroListDialogBaseClip
   {
       
      
      public var tf_max_level:SpecialClipLabel;
      
      public var tf_amount_label:ClipLabel;
      
      public var tf_use_label:ClipLabel;
      
      public var LinePale_148_148_1_inst0:GuiClipScale3Image;
      
      public var potion_icon_inst0:HeroListDialogPotionIconClip;
      
      public var layout_header:ClipLayout;
      
      public function HeroUseConsumableDialogClip()
      {
         tf_max_level = new SpecialClipLabel();
         tf_amount_label = new ClipLabel(true);
         tf_use_label = new ClipLabel(true);
         LinePale_148_148_1_inst0 = new GuiClipScale3Image(148,1);
         potion_icon_inst0 = new HeroListDialogPotionIconClip();
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_use_label,potion_icon_inst0,tf_amount_label);
         super();
      }
   }
}
