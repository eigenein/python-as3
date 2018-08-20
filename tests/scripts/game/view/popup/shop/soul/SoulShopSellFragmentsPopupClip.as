package game.view.popup.shop.soul
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.quest.QuestRewardItemRenderer;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class SoulShopSellFragmentsPopupClip extends GuiClipNestedContainer
   {
       
      
      public var scrollbar:GameScrollBar;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var list:ClipListWithScroll;
      
      public var list_item:ClipDataProvider;
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_title:ClipLabel;
      
      public var tf_not_enough:ClipLabel;
      
      public var tf_reward_label:ClipLabel;
      
      public var reward:QuestRewardItemRenderer;
      
      public var layour_reward:ClipLayout;
      
      public function SoulShopSellFragmentsPopupClip()
      {
         scrollbar = new GameScrollBar();
         list = new ClipListWithScroll(InventoryItemRenderer,scrollbar);
         list_item = list.itemClipProvider;
         tf_reward_label = new ClipLabel(true);
         reward = new QuestRewardItemRenderer();
         layour_reward = ClipLayout.horizontalMiddleCentered(3,tf_reward_label,reward);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         list.addGradients(gradient_top.graphics,gradient_bottom.graphics);
      }
   }
}
