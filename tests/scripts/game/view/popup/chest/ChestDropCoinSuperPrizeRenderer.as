package game.view.popup.chest
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ChestDropCoinSuperPrizeRenderer extends GuiClipNestedContainer
   {
       
      
      public var tf_1:ClipLabel;
      
      public var tf_2:ClipLabel;
      
      public var tf_3:ClipLabel;
      
      public var item_icon:InventoryItemRenderer;
      
      public function ChestDropCoinSuperPrizeRenderer()
      {
         tf_1 = new ClipLabel();
         tf_2 = new ClipLabel();
         tf_3 = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:GuiAnimation = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_hihlite_back");
         container.addChildAt(_loc2_.graphics,0);
      }
   }
}
