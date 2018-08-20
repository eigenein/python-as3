package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class TitanPopupUpgradeLevelInfoClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_level_up_1:ClipLabel;
      
      public var tf_label_level_up_2:ClipLabel;
      
      public var button_level_up_1:ClipButtonLabeled;
      
      public var button_level_up_2:ClipButtonLabeled;
      
      public var price_1:QuestRewardItemRenderer;
      
      public var price_2:QuestRewardItemRenderer;
      
      public var layout_consumable_cost:ClipLayout;
      
      public var layout_star_money_cost:ClipLayout;
      
      public function TitanPopupUpgradeLevelInfoClip()
      {
         tf_label_level_up_1 = new ClipLabel();
         tf_label_level_up_2 = new ClipLabel();
         button_level_up_1 = new ClipButtonLabeled();
         button_level_up_2 = new ClipButtonLabeled();
         price_1 = new QuestRewardItemRenderer();
         price_2 = new QuestRewardItemRenderer();
         layout_consumable_cost = ClipLayout.horizontalMiddleCentered(10,price_1,button_level_up_1);
         layout_star_money_cost = ClipLayout.horizontalMiddleCentered(10,price_2,button_level_up_2);
         super();
      }
   }
}
