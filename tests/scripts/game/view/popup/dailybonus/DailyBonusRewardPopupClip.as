package game.view.popup.dailybonus
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.inventory.PlayerInventoryItemTile;
   
   public class DailyBonusRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_farm:ClipButtonLabeled;
      
      public var t_vip_info:ClipLabel;
      
      public var tf_caption:ClipLabel;
      
      public var tf_item_name:ClipLabel;
      
      public var alchemy_shinyLine_inst0:ClipSprite;
      
      public var exclamation:ClipSprite;
      
      public var glow:ClipSprite;
      
      public var inventory_item:PlayerInventoryItemTile;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var panel:GuiClipScale9Image;
      
      public var layout_reward:ClipLayout;
      
      public var layout_vip_notice:ClipLayout;
      
      public var layout_main:ClipLayout;
      
      public function DailyBonusRewardPopupClip()
      {
         button_farm = new ClipButtonLabeled();
         t_vip_info = new ClipLabel();
         tf_caption = new ClipLabel();
         tf_item_name = new ClipLabel();
         alchemy_shinyLine_inst0 = new ClipSprite();
         exclamation = new ClipSprite();
         glow = new ClipSprite();
         inventory_item = new PlayerInventoryItemTile();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         panel = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_reward = ClipLayout.none(tf_item_name,glow,inventory_item);
         layout_vip_notice = ClipLayout.none(t_vip_info,alchemy_shinyLine_inst0,exclamation);
         layout_main = ClipLayout.verticalMiddleCenter(4,layout_reward,layout_vip_notice);
         super();
      }
   }
}
