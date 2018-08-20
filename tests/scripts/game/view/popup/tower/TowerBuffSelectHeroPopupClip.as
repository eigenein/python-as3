package game.view.popup.tower
{
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.HeroListDialogBaseClip;
   import game.view.popup.hero.HeroListDialogPotionIconClip;
   
   public class TowerBuffSelectHeroPopupClip extends HeroListDialogBaseClip
   {
       
      
      public var tf_use_label:ClipLabel;
      
      public var tf_item_label:ClipLabel;
      
      public var itemIcon:HeroListDialogPotionIconClip;
      
      public var layout_header:ClipLayout;
      
      public function TowerBuffSelectHeroPopupClip()
      {
         tf_use_label = new ClipLabel(true);
         tf_item_label = new ClipLabel(true);
         itemIcon = new HeroListDialogPotionIconClip();
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_use_label,tf_item_label,itemIcon);
         super();
      }
   }
}
