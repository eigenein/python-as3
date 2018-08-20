package game.view.popup.artifactchest.rewardpopup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArtifactChestRewardPopupClipMulti100 extends GuiClipNestedContainer
   {
       
      
      public var tf_reward_title:ClipLabel;
      
      public var button_browes:ClipButton;
      
      public var reward_title_container:ClipLayout;
      
      public var reward_list_container:ClipLayout;
      
      public function ArtifactChestRewardPopupClipMulti100()
      {
         tf_reward_title = new ClipLabel(true);
         button_browes = new ClipButton();
         reward_title_container = ClipLayout.horizontalMiddleCentered(10,tf_reward_title,button_browes);
         reward_list_container = ClipLayout.tiledMiddleCentered(8);
         super();
      }
   }
}
