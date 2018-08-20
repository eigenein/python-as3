package game.view.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class ChestQuestPromoClip extends GuiClipNestedContainer
   {
       
      
      public var label_questTask:ClipLabel;
      
      public var tf_label_questReward:ClipLabel;
      
      public var NewIcon_inst0:ClipSprite;
      
      public var NewIcon_inst1:ClipSprite;
      
      public var line:ClipSprite;
      
      public var reward_item_1:QuestRewardItemRenderer;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function ChestQuestPromoClip()
      {
         label_questTask = new ClipLabel();
         tf_label_questReward = new ClipLabel();
         NewIcon_inst0 = new ClipSprite();
         NewIcon_inst1 = new ClipSprite();
         line = new ClipSprite();
         reward_item_1 = new QuestRewardItemRenderer();
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      public function setData(param1:PlayerQuestValueObject) : void
      {
         tf_label_questReward.text = Translate.translate("UI_DIALOG_QUEST_REWARD");
         label_questTask.text = param1.taskDescription;
         reward_item_1.data = param1.rewards[0];
      }
   }
}
