package game.mechanics.dungeon.popup.reward
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class DungeonRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_description:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var floor_number:ClipLabel;
      
      public var glow:ClipSprite;
      
      public var list_item_1:InventoryItemRenderer;
      
      public var list_item_2:InventoryItemRenderer;
      
      public var list_item_3:InventoryItemRenderer;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_item_list:ClipLayout;
      
      public function DungeonRewardPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_description = new ClipLabel();
         tf_label_reward = new ClipLabel();
         floor_number = new ClipLabel();
         glow = new ClipSprite();
         list_item_1 = new InventoryItemRenderer();
         list_item_2 = new InventoryItemRenderer();
         list_item_3 = new InventoryItemRenderer();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_item_list = ClipLayout.horizontalMiddleCentered(0,list_item_1,list_item_2,list_item_3);
         super();
      }
   }
}
