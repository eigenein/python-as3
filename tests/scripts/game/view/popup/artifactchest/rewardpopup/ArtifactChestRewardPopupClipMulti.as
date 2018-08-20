package game.view.popup.artifactchest.rewardpopup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class ArtifactChestRewardPopupClipMulti extends GuiClipNestedContainer
   {
       
      
      public var scrollbar_rewards:GameScrollBar;
      
      public var list_rewards:GameScrolledList;
      
      public function ArtifactChestRewardPopupClipMulti()
      {
         scrollbar_rewards = new GameScrollBar();
         list_rewards = new GameScrolledList(scrollbar_rewards,null,null);
         super();
      }
   }
}
