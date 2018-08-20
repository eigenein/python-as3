package game.view.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.chest.reward.ChestRewardPopupItemTile;
   
   public class PlayerMailMultifarmPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_farm_all:ClipButtonLabeled;
      
      public var reward_item_1:ChestRewardPopupItemTile;
      
      public var reward_item_2:ChestRewardPopupItemTile;
      
      public var reward_item_3:ChestRewardPopupItemTile;
      
      public var reward_item_4:ChestRewardPopupItemTile;
      
      public var reward_item_5:ChestRewardPopupItemTile;
      
      public var reward_item_6:ChestRewardPopupItemTile;
      
      public var reward_item_7:ChestRewardPopupItemTile;
      
      public var reward_item_8:ChestRewardPopupItemTile;
      
      public var reward_item_9:ChestRewardPopupItemTile;
      
      public var reward_item_10:ChestRewardPopupItemTile;
      
      public var reward_items:Vector.<ChestRewardPopupItemTile>;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_tiles:ClipLayout;
      
      public function PlayerMailMultifarmPopupClip()
      {
         button_farm_all = new ClipButtonLabeled();
         reward_item_1 = new ChestRewardPopupItemTile();
         reward_item_2 = new ChestRewardPopupItemTile();
         reward_item_3 = new ChestRewardPopupItemTile();
         reward_item_4 = new ChestRewardPopupItemTile();
         reward_item_5 = new ChestRewardPopupItemTile();
         reward_item_6 = new ChestRewardPopupItemTile();
         reward_item_7 = new ChestRewardPopupItemTile();
         reward_item_8 = new ChestRewardPopupItemTile();
         reward_item_9 = new ChestRewardPopupItemTile();
         reward_item_10 = new ChestRewardPopupItemTile();
         reward_items = new <ChestRewardPopupItemTile>[reward_item_1,reward_item_2,reward_item_3,reward_item_4,reward_item_5,reward_item_6,reward_item_7,reward_item_8,reward_item_9,reward_item_10];
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_tiles = ClipLayout.tiledMiddleCentered(4);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_farm_all.label = Translate.translate("UI_DIALOG_MAIL_ENTRY_FARM");
         var _loc4_:int = 0;
         var _loc3_:* = reward_items;
         for each(var _loc2_ in reward_items)
         {
            layout_tiles.addChild(_loc2_.graphics);
         }
      }
   }
}
