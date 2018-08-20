package game.mechanics.quiz.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class QuizStartPopupClip extends GuiClipNestedContainer
   {
       
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var button_close:ClipButton;
      
      public var blue_labeled_button_134_inst0:ClipButtonLabeled;
      
      public var boring_buttonClip_inst0:ClipButtonLabeled;
      
      public var button_1:ClipButtonLabeled;
      
      public var button_10:ClipButtonLabeled;
      
      public var tf_label_footer:ClipLabel;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_label_points:ClipLabel;
      
      public var tf_label_tickets:ClipLabel;
      
      public var tf_select_quiestion:ClipLabel;
      
      public var reward_item_1:QuestRewardItemRenderer;
      
      public var reward_item_2:QuestRewardItemRenderer;
      
      public var layout_bottom:ClipLayout;
      
      public function QuizStartPopupClip()
      {
         bounds_layout_container = new GuiClipLayoutContainer();
         button_close = new ClipButton();
         blue_labeled_button_134_inst0 = new ClipButtonLabeled();
         boring_buttonClip_inst0 = new ClipButtonLabeled();
         button_1 = new ClipButtonLabeled();
         button_10 = new ClipButtonLabeled();
         tf_label_footer = new ClipLabel();
         tf_label_header = new ClipLabel();
         tf_label_points = new ClipLabel();
         tf_label_tickets = new ClipLabel();
         tf_select_quiestion = new ClipLabel();
         reward_item_1 = new QuestRewardItemRenderer();
         reward_item_2 = new QuestRewardItemRenderer();
         layout_bottom = ClipLayout.horizontalMiddleCentered(4,tf_label_footer,boring_buttonClip_inst0,blue_labeled_button_134_inst0);
         super();
      }
   }
}
