package game.view.popup.arena.rules
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ArenaRulesContentClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_place:ClipLabel;
      
      public var tf_label_reward:ClipLabel;
      
      public var tf_reward_list_caption:ClipLabel;
      
      public var tf_rules:ClipLabel;
      
      public var reward_block:ArenaRulesCurrentPlaceRewardClip;
      
      public var place_block:ArenaRulesPlaceClip;
      
      public var layout:ClipLayout;
      
      public function ArenaRulesContentClip()
      {
         tf_label_place = new ClipLabel();
         tf_label_reward = new ClipLabel();
         tf_reward_list_caption = new ClipLabel();
         tf_rules = new ClipLabel();
         reward_block = new ArenaRulesCurrentPlaceRewardClip();
         place_block = new ArenaRulesPlaceClip();
         layout = ClipLayout.verticalCenter(8,tf_rules,tf_label_place,place_block,tf_label_reward,reward_block,tf_reward_list_caption);
         super();
      }
   }
}
