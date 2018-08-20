package game.view.popup.ny.sendgift
{
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.friends.SearchableFriendListPopupClipBase;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class SelectFriendToSendNYGiftPopupClip extends SearchableFriendListPopupClipBase
   {
       
      
      public var layout_tabs:ClipLayout;
      
      public var tf_search:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_amount:ClipLabel;
      
      public var btn_send:ClipButtonLabeled;
      
      public var btn_minus:ClipButton;
      
      public var btn_plus:ClipButton;
      
      public var price:QuestRewardItemRenderer;
      
      public var tf_price:ClipLabel;
      
      public var tf_reward:ClipLabel;
      
      public var reward1:QuestRewardItemRenderer;
      
      public var reward2:QuestRewardItemRenderer;
      
      public var layout_price:ClipLayout;
      
      public var tf_receiver:ClipLabel;
      
      public var tf_warning:ClipLabel;
      
      public var warning_bg:GuiClipScale9Image;
      
      public function SelectFriendToSendNYGiftPopupClip()
      {
         layout_tabs = ClipLayout.vertical(-16);
         tf_search = new ClipLabel();
         tf_header = new ClipLabel();
         tf_amount = new ClipLabel();
         btn_send = new ClipButtonLabeled();
         btn_minus = new ClipButton();
         btn_plus = new ClipButton();
         price = new QuestRewardItemRenderer();
         tf_price = new ClipLabel(true);
         tf_reward = new ClipLabel(true);
         reward1 = new QuestRewardItemRenderer();
         reward2 = new QuestRewardItemRenderer();
         layout_price = ClipLayout.horizontalMiddleCentered(10,tf_price,price,tf_reward,reward1,reward2);
         tf_receiver = new ClipLabel();
         tf_warning = new ClipLabel();
         warning_bg = new GuiClipScale9Image();
         super();
      }
   }
}
