package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class SubscriptionPopupListRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_daily:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var reward_item:QuestRewardItemRenderer;
      
      public var layout_reward:ClipLayout;
      
      public var frame:GuiClipScale9Image;
      
      public var arrow_after:ClipSprite;
      
      public var arrow_before:ClipSprite;
      
      public function SubscriptionPopupListRendererClip()
      {
         tf_label_daily = new ClipLabel();
         tf_level = new ClipLabel();
         reward_item = new QuestRewardItemRenderer();
         layout_reward = ClipLayout.horizontalMiddleCentered(4,reward_item);
         frame = new GuiClipScale9Image();
         arrow_after = new ClipSprite();
         arrow_before = new ClipSprite();
         super();
      }
   }
}
