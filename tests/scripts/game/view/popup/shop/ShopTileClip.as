package game.view.popup.shop
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   
   public class ShopTileClip extends GuiClipNestedContainer
   {
       
      
      public var cost_panel:ShopCostPanel;
      
      public var tf_bought:ClipLabel;
      
      public var item_renderer:PlayerInventoryItemTile;
      
      public var tf_item_name:ClipLabel;
      
      public var button_buy:ClipButtonLabeled;
      
      public var bg:GuiClipScale9Image;
      
      public function ShopTileClip()
      {
         button_buy = new ClipButtonLabeled();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
         tf_item_name = new ClipLabel();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
