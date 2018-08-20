package game.view.popup.mail
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class PlayerMailEntryPopupClip extends PopupClipBase
   {
       
      
      public var button_farm_all:ClipButtonLabeled;
      
      public var button_farm_and_send:ClipButtonLabeled;
      
      public var tf_body:SpecialClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_available:ClipLabel;
      
      public var reward_tile_1:InventoryItemRenderer;
      
      public var reward_tile_2:InventoryItemRenderer;
      
      public var reward_tile_3:InventoryItemRenderer;
      
      public var reward_tile_4:InventoryItemRenderer;
      
      public var reward_tile_5:InventoryItemRenderer;
      
      public var reward_tile_6:InventoryItemRenderer;
      
      public var reward_tiles:Vector.<InventoryItemRenderer>;
      
      public var LinePale_148_148_1_inst0:GuiClipScale3Image;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var layout_reward:ClipLayout;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list_container:ClipLayout;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var layout_buttons:ClipLayout;
      
      public function PlayerMailEntryPopupClip()
      {
         button_farm_all = new ClipButtonLabeled();
         button_farm_and_send = new ClipButtonLabeled();
         tf_body = new SpecialClipLabel();
         tf_label_reward = new ClipLabel();
         tf_available = new ClipLabel();
         reward_tile_1 = new InventoryItemRenderer();
         reward_tile_2 = new InventoryItemRenderer();
         reward_tile_3 = new InventoryItemRenderer();
         reward_tile_4 = new InventoryItemRenderer();
         reward_tile_5 = new InventoryItemRenderer();
         reward_tile_6 = new InventoryItemRenderer();
         reward_tiles = new <InventoryItemRenderer>[reward_tile_1,reward_tile_2,reward_tile_3,reward_tile_4,reward_tile_5,reward_tile_6];
         LinePale_148_148_1_inst0 = new GuiClipScale3Image(148,1);
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list_container = ClipLayout.vertical(0);
         scroll_slider_container = new GuiClipLayoutContainer();
         layout_buttons = ClipLayout.horizontalMiddleCentered(5,button_farm_all);
         layout_reward = ClipLayout.horizontalCentered(4,reward_tile_1,reward_tile_2,reward_tile_3,reward_tile_4,reward_tile_5,reward_tile_6);
         super();
      }
   }
}
