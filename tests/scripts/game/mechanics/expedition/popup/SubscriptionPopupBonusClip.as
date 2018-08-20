package game.mechanics.expedition.popup
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class SubscriptionPopupBonusClip extends ClipAnimatedContainer
   {
       
      
      public const epic_arrow:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const tf_label_activation_bonus:ClipLabel = new ClipLabel();
      
      public const icon_yellow_plus:ClipSprite = new ClipSprite();
      
      public const reward_item:QuestRewardItemRenderer = new QuestRewardItemRenderer();
      
      public function SubscriptionPopupBonusClip(param1:Boolean = false)
      {
         super(param1);
      }
   }
}
