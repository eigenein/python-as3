package game.view.popup.hero.slot
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.inventory.ItemDescriptionClip;
   
   public class ClipHeroSlotItemDescription extends GuiClipNestedContainer
   {
       
      
      public var item_icon:InventoryItemIcon;
      
      public var tf_item_name:ClipLabel;
      
      public var tf_item_in_stock_label:ClipLabel;
      
      public var tf_item_in_stock:ClipLabel;
      
      public var layout_in_stock:ClipLayout;
      
      public var tf_item_requirements:ClipLabel;
      
      public var tf_green_item_requirements:ClipLabel;
      
      public var itemDesc:ItemDescriptionClip;
      
      public function ClipHeroSlotItemDescription()
      {
         tf_item_in_stock_label = new ClipLabel(true);
         tf_item_in_stock = new ClipLabel(true);
         layout_in_stock = ClipLayout.horizontal(4,tf_item_in_stock_label,tf_item_in_stock);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
