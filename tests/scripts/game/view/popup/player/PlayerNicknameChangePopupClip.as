package game.view.popup.player
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.shop.ShopCostPanel;
   
   public class PlayerNicknameChangePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_caption:ClipLabel;
      
      public var tf_validation_notice:ClipLabel;
      
      public var tf_name_input:ClipInput;
      
      public var btn_change:ClipButtonLabeled;
      
      public var btn_random:ClipButtonLabeled;
      
      public var cost:ShopCostPanel;
      
      public var layout_cost_btn:ClipLayout;
      
      public function PlayerNicknameChangePopupClip()
      {
         button_close = new ClipButton();
         tf_caption = new ClipLabel();
         tf_validation_notice = new ClipLabel();
         tf_name_input = new ClipInput();
         btn_change = new ClipButtonLabeled();
         btn_random = new ClipButtonLabeled();
         cost = new ShopCostPanel();
         layout_cost_btn = ClipLayout.verticalMiddleCenter(4,cost,btn_change);
         super();
      }
   }
}
