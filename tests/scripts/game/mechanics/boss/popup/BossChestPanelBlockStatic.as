package game.mechanics.boss.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class BossChestPanelBlockStatic extends GuiClipNestedContainer
   {
       
      
      public var item_reward:InventoryItemRenderer;
      
      public var item_reward_pack_1:InventoryItemRenderer;
      
      public var item_reward_pack_2:InventoryItemRenderer;
      
      public var item_reward_free:InventoryItemRenderer;
      
      public var tf_label:ClipLabel;
      
      public var bg_label:ClipSprite;
      
      public var animation_get_free:GuiAnimation;
      
      public function BossChestPanelBlockStatic()
      {
         item_reward = new InventoryItemRenderer();
         item_reward_pack_1 = new InventoryItemRenderer();
         item_reward_pack_2 = new InventoryItemRenderer();
         item_reward_free = new InventoryItemRenderer();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         animation_get_free.hide();
         animation_get_free.stop();
      }
   }
}
