package game.view.popup.shop.special
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SpecialShopPopupHeroClip extends GuiClipNestedContainer
   {
       
      
      public var label_name:ClipLabel;
      
      public var layout_name:ClipLayout;
      
      public var HeroGlowBG_scale_inst0:ClipSprite;
      
      public var hero_position:GuiClipContainer;
      
      public var inventory_slot_6:SpecialShopInventoryItemRenderer;
      
      public var inventory_slot_5:SpecialShopInventoryItemRenderer;
      
      public var inventory_slot_4:SpecialShopInventoryItemRenderer;
      
      public var inventory_slot_3:SpecialShopInventoryItemRenderer;
      
      public var inventory_slot_2:SpecialShopInventoryItemRenderer;
      
      public var inventory_slot_1:SpecialShopInventoryItemRenderer;
      
      public var ribbon_image:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public function SpecialShopPopupHeroClip()
      {
         label_name = new ClipLabel(true);
         layout_name = ClipLayout.horizontalMiddleCentered(4);
         HeroGlowBG_scale_inst0 = new ClipSprite();
         ribbon_image = new GuiClipScale3Image(76,1);
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
