package game.view.popup.hero.slot
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.List;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.hero.InventoryItemRecipeMediator;
   import game.view.gui.components.ClipButtonLabeledGlow;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipList;
   import game.view.gui.components.InventoryItemIcon;
   
   public class ClipCraftBlock extends GuiClipNestedContainer
   {
       
      
      public var button_craft:ClipButtonLabeledGlow;
      
      public var item_icon:InventoryItemIcon;
      
      public var tf_item_price_label:ClipLabel;
      
      public var tf_item_price:ClipLabel;
      
      public var craft_recipe_list:ClipList;
      
      public var craft_recipe_item:ClipDataProvider;
      
      public function ClipCraftBlock()
      {
         super();
         craft_recipe_list = new ClipList(ClipListItemCraftRecipe);
         craft_recipe_item = craft_recipe_list.itemClipProvider;
         craft_recipe_list.list = new List();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         craft_recipe_list.list.layout = _loc1_;
         craft_recipe_list.list.verticalScrollPolicy = "off";
      }
      
      public function setCurrentItem(param1:InventoryItemRecipeMediator) : void
      {
         if(craft_recipe_list.list.dataProvider)
         {
            craft_recipe_list.list.dataProvider.data = param1.craftRecipe.concat();
         }
         else
         {
            craft_recipe_list.list.dataProvider = new ListCollection(param1.craftRecipe);
         }
         craft_recipe_list.list.validate();
         item_icon.setItemDescription(param1.item);
         tf_item_price_label.text = Translate.translate("UI_DIALOG_HERO_INVENTORY_SLOT_CRAFT_COST");
         if(param1.mergeCost)
         {
            tf_item_price.text = String(param1.mergeCost.amount);
         }
         else
         {
            tf_item_price.text = "0";
         }
      }
   }
}
