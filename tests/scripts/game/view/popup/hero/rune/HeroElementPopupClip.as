package game.view.popup.hero.rune
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class HeroElementPopupClip extends PopupClipBase
   {
       
      
      public var bound_layout_container:GuiClipLayoutContainer;
      
      public var minilist_layout_container:ClipLayout;
      
      public var miniList_rightArrow:ClipButton;
      
      public var miniList_leftArrow:ClipButton;
      
      public var hero_position:GuiClipLayoutContainer;
      
      public var tf_activate:SpecialClipLabel;
      
      public var tf_skill1:ClipLabel;
      
      public var tf_skill2:ClipLabel;
      
      public var tf_skill3:ClipLabel;
      
      public var tf_skill1_value:SpecialClipLabel;
      
      public var tf_skill2_value:SpecialClipLabel;
      
      public var tf_skill3_value:SpecialClipLabel;
      
      public var skill1_container:ClipLayout;
      
      public var skill2_container:ClipLayout;
      
      public var skill3_container:ClipLayout;
      
      public var price_1:QuestRewardItemRenderer;
      
      public var price_2:QuestRewardItemRenderer;
      
      public var btn_action:ClipButtonLabeled;
      
      public var layout_price_action:ClipLayout;
      
      public var tf_desc:SpecialClipLabel;
      
      public var btn_reset:ClipButtonLabeled;
      
      public var circle_container:ClipLayout;
      
      public var layout_tabs:ClipLayout;
      
      public function HeroElementPopupClip()
      {
         minilist_layout_container = ClipLayout.horizontalCentered(0);
         tf_activate = new SpecialClipLabel();
         tf_skill1 = new ClipLabel();
         tf_skill2 = new ClipLabel();
         tf_skill3 = new ClipLabel();
         tf_skill1_value = new SpecialClipLabel();
         tf_skill2_value = new SpecialClipLabel();
         tf_skill3_value = new SpecialClipLabel();
         skill1_container = ClipLayout.anchor();
         skill2_container = ClipLayout.anchor();
         skill3_container = ClipLayout.anchor();
         price_1 = new QuestRewardItemRenderer();
         price_2 = new QuestRewardItemRenderer();
         btn_action = new ClipButtonLabeled();
         layout_price_action = ClipLayout.horizontalMiddleCentered(10,price_1,price_2,btn_action);
         tf_desc = new SpecialClipLabel();
         btn_reset = new ClipButtonLabeled();
         circle_container = ClipLayout.horizontalCentered(0);
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
   }
}
