package game.view.popup.friends.socialquest
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   
   public class SocialQuestRewardBlock extends GuiClipNestedContainer
   {
       
      
      public var quest_reward_1:RewardItemClip;
      
      public var quest_reward_2:RewardItemClip;
      
      public var quest_reward_3:RewardItemClip;
      
      public var layout_reward:ClipLayout;
      
      public function SocialQuestRewardBlock()
      {
         quest_reward_1 = new RewardItemClip();
         quest_reward_2 = new RewardItemClip();
         quest_reward_3 = new RewardItemClip();
         layout_reward = ClipLayout.horizontalMiddleCentered(4,quest_reward_1,quest_reward_2,quest_reward_3);
         super();
      }
   }
}
