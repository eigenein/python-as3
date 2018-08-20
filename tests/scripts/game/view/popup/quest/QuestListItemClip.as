package game.view.popup.quest
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class QuestListItemClip extends GuiClipNestedContainer
   {
       
      
      public var frame:ClipSprite;
      
      public var item_container:GuiClipContainer;
      
      public var bg:GuiClipScale9Image;
      
      public var label_questProgress:ClipLabel;
      
      public var tf_label_questReward:ClipLabel;
      
      public var label_questTask:SpecialClipLabel;
      
      public var button_go:ClipButtonLabeled;
      
      public var button_finish:ClipButtonLabeled;
      
      public var reward_item_1:QuestRewardItemRenderer;
      
      public var reward_item_2:QuestRewardItemRenderer;
      
      public var reward_item_3:QuestRewardItemRenderer;
      
      public var reward_items:Vector.<QuestRewardItemRenderer>;
      
      public var layout_reward:ClipLayout;
      
      public function QuestListItemClip()
      {
         tf_label_questReward = new ClipLabel(true);
         reward_item_1 = new QuestRewardItemRenderer();
         reward_item_2 = new QuestRewardItemRenderer();
         reward_item_3 = new QuestRewardItemRenderer();
         reward_items = new Vector.<QuestRewardItemRenderer>();
         layout_reward = ClipLayout.horizontalMiddleLeft(4,tf_label_questReward,reward_item_1,reward_item_2,reward_item_3);
         super();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
      }
      
      override public function setNode(param1:Node) : void
      {
         var _loc2_:int = 0;
         super.setNode(param1);
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            reward_items.push(this["reward_item_" + _loc2_] as QuestRewardItemRenderer);
            _loc2_++;
         }
         tf_label_questReward.text = Translate.translate("UI_DIALOG_QUEST_REWARD");
      }
      
      public function dispose() : void
      {
         reward_item_1.dispose();
         reward_item_2.dispose();
         reward_item_3.dispose();
      }
   }
}
