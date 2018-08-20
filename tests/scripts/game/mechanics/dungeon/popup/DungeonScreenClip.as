package game.mechanics.dungeon.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class DungeonScreenClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_finish:ClipButtonLabeled;
      
      public var button_guide:ClipButtonLabeled;
      
      public var button_titans:ClipButtonLabeled;
      
      public var icon_new:ClipSprite;
      
      public var tf_label_questReward:ClipLabel;
      
      public var tf_quest:ClipLabel;
      
      public var tf_titanite:ClipLabel;
      
      public var tf_titanite_yours:ClipLabel;
      
      public var dungeonActivityIcon50_inst0:ClipSprite;
      
      public var progress_titanite:TitaniteProgressBarClip;
      
      public var reward_item:InventoryItemRenderer;
      
      public var quest_reward:QuestRewardItemRenderer;
      
      public var layout_reward:ClipLayout;
      
      public var layout_titanite_progress:ClipLayout;
      
      public var layout_titanite:ClipLayout;
      
      public var layout_quest:ClipLayout;
      
      public function DungeonScreenClip()
      {
         button_close = new ClipButton();
         button_finish = new ClipButtonLabeled();
         button_guide = new ClipButtonLabeled();
         button_titans = new ClipButtonLabeled();
         icon_new = new ClipSprite();
         tf_label_questReward = new ClipLabel(true);
         tf_quest = new ClipLabel();
         tf_titanite = new ClipLabel();
         tf_titanite_yours = new ClipLabel();
         dungeonActivityIcon50_inst0 = new ClipSprite();
         progress_titanite = new TitaniteProgressBarClip();
         reward_item = new InventoryItemRenderer();
         quest_reward = new QuestRewardItemRenderer();
         layout_reward = ClipLayout.horizontalMiddleCentered(4,tf_label_questReward,quest_reward,button_finish);
         layout_titanite_progress = ClipLayout.none(dungeonActivityIcon50_inst0,progress_titanite,tf_titanite_yours,reward_item);
         layout_titanite = ClipLayout.verticalMiddleCenter(4,tf_titanite);
         layout_quest = ClipLayout.verticalMiddleCenter(4,tf_quest);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_quest.addChild(layout_reward);
         layout_titanite.addChild(layout_titanite_progress);
      }
   }
}
