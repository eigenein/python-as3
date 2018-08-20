package game.view.popup.summoningcircle.reward
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SummoningCircleRewardPopupClipMultiExtended extends GuiClipNestedContainer
   {
       
      
      public var tf_reward_title:ClipLabel;
      
      public var button_browes:ClipButton;
      
      public var reward_title_container:ClipLayout;
      
      public var reward_item_:Vector.<InventoryItemRenderer>;
      
      public function SummoningCircleRewardPopupClipMultiExtended()
      {
         tf_reward_title = new ClipLabel(true);
         button_browes = new ClipButton();
         reward_title_container = ClipLayout.horizontalMiddleCentered(10,tf_reward_title,button_browes);
         super();
      }
   }
}
