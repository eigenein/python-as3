package game.view.popup.ny.treeupgrade
{
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.CheckBoxLabeledGuiToggleButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class NYFireworksLaunchPopupClip extends PopupClipBase
   {
       
      
      public var popup_bg:GuiClipScale9Image;
      
      public var tf_desc_1:ClipLabel;
      
      public var tf_desc_2:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var btn_send:ClipButtonLabeled;
      
      public var check_1:CheckBoxLabeledGuiToggleButton;
      
      public var check_2:CheckBoxLabeledGuiToggleButton;
      
      public var item1:InventoryItemRenderer;
      
      public var item2:InventoryItemRenderer;
      
      public var price:QuestRewardItemRenderer;
      
      public var layout_checkboxes:ClipLayout;
      
      public var layout_reward_1:ClipLayout;
      
      public var layout_reward_2:ClipLayout;
      
      public function NYFireworksLaunchPopupClip()
      {
         popup_bg = new GuiClipScale9Image();
         tf_desc_1 = new ClipLabel();
         tf_desc_2 = new ClipLabel();
         tf_header = new ClipLabel();
         btn_send = new ClipButtonLabeled();
         check_1 = new CheckBoxLabeledGuiToggleButton();
         check_2 = new CheckBoxLabeledGuiToggleButton();
         item1 = new InventoryItemRenderer();
         item2 = new InventoryItemRenderer();
         price = new QuestRewardItemRenderer();
         layout_checkboxes = ClipLayout.horizontalMiddleCentered(30,check_1,check_2);
         layout_reward_1 = ClipLayout.horizontalMiddleCentered(4,tf_desc_1);
         layout_reward_2 = ClipLayout.horizontalMiddleCentered(4,tf_desc_2);
         super();
      }
   }
}
