package game.mediator.gui.popup.hero
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class HeroTitanGiftLevelDropPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_message:ClipLabel;
      
      public var tf_recieve:ClipLabel;
      
      public var price:QuestRewardItemRenderer;
      
      public var layout_group:ClipLayout;
      
      public var btn_continue:ClipButtonLabeled;
      
      public var btn_drop:ClipButtonLabeled;
      
      public function HeroTitanGiftLevelDropPopUpClip()
      {
         tf_message = new ClipLabel();
         tf_recieve = new ClipLabel(true);
         price = new QuestRewardItemRenderer();
         layout_group = ClipLayout.horizontalMiddleCentered(10,tf_recieve,price);
         btn_continue = new ClipButtonLabeled();
         btn_drop = new ClipButtonLabeled();
         super();
      }
   }
}
