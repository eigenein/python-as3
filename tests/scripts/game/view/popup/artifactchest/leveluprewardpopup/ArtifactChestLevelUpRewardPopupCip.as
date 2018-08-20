package game.view.popup.artifactchest.leveluprewardpopup
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ArtifactChestLevelUpRewardPopupCip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_level:ClipLabel;
      
      public var tf_label_item_name:ClipLabel;
      
      public var key_content:ArtifactChestLevelUpRewardKeyContentCip;
      
      public var reward_item1:InventoryItemRenderer;
      
      public var reward_item2:InventoryItemRenderer;
      
      public var sun_animation:GuiAnimation;
      
      public var ribbon:RewardDialogRibbonHeader;
      
      public function ArtifactChestLevelUpRewardPopupCip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_level = new ClipLabel();
         tf_label_item_name = new ClipLabel();
         key_content = new ArtifactChestLevelUpRewardKeyContentCip();
         reward_item1 = new InventoryItemRenderer();
         reward_item2 = new InventoryItemRenderer();
         sun_animation = new GuiAnimation();
         ribbon = new RewardDialogRibbonHeader();
         super();
      }
   }
}
