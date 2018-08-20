package game.view.popup.reward.multi
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.HorizontalLayout;
   import game.model.user.inventory.InventoryItemValueObject;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.hero.slot.ClipListItemCraftRecipe;
   
   public class MultiRewardGroupedPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_farm:ClipButtonLabeled;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var item_to_look_for:ClipListItemCraftRecipe;
      
      public var tf_looking_for:ClipLabel;
      
      public var looking_for_panel:GuiClipScale9Image;
      
      public function MultiRewardGroupedPopupClip()
      {
         button_farm = new ClipButtonLabeled();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         item_to_look_for = new ClipListItemCraftRecipe();
         tf_looking_for = new ClipLabel();
         looking_for_panel = new GuiClipScale9Image();
         super();
      }
      
      public function setItemLookingFor(param1:InventoryItemValueObject) : void
      {
         if(param1)
         {
            item_to_look_for.setData(param1);
            (item_to_look_for.layout.layout as HorizontalLayout).horizontalAlign = "left";
         }
         var _loc2_:Boolean = param1;
         item_to_look_for.graphics.visible = _loc2_;
         tf_looking_for.visible = _loc2_;
         looking_for_panel.graphics.visible = _loc2_;
         if(!_loc2_ && item_to_look_for.graphics.parent)
         {
            container.removeChild(item_to_look_for.graphics);
            container.removeChild(tf_looking_for.graphics);
            container.removeChild(looking_for_panel.graphics);
         }
      }
   }
}
