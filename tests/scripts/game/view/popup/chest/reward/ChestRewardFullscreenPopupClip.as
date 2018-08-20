package game.view.popup.chest.reward
{
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.refillable.CostButton;
   
   public class ChestRewardFullscreenPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var cost_button_more:CostButton;
      
      public var tf_item_name:ClipLabel;
      
      public var tf_label_item_name:ClipLabel;
      
      public var tf_label_item_name_multi:ClipLabel;
      
      public var tf_open_pack:ClipLabel;
      
      public var tf_hero_drop_desc:ClipLabel;
      
      public var tf_chest_promt:ClipLabel;
      
      public var multi_reward_list:ChestRewardPopupClipMulti;
      
      public var reward_item:ChestRewardPopupRenderer;
      
      public var placeholder_chest:GuiClipContainer;
      
      public var placeholder_ribbon:GuiClipContainer;
      
      public function ChestRewardFullscreenPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         cost_button_more = new CostButton();
         tf_item_name = new ClipLabel();
         tf_label_item_name = new ClipLabel();
         tf_label_item_name_multi = new ClipLabel();
         tf_open_pack = new ClipLabel();
         tf_hero_drop_desc = new ClipLabel();
         tf_chest_promt = new ClipLabel();
         multi_reward_list = new ChestRewardPopupClipMulti();
         reward_item = new ChestRewardPopupRenderer();
         placeholder_chest = new GuiClipContainer();
         placeholder_ribbon = new GuiClipContainer();
         super();
      }
   }
}
