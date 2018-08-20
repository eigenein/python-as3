package game.view.popup.clan
{
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.shop.ShopCostPanel;
   
   public class ClanCreatePopupClip extends PopupClipBase
   {
       
      
      public var level_minus:ClipButton;
      
      public var level_plus:ClipButton;
      
      public var button_create:ClipButtonLabeled;
      
      public var button_banner_change:ClipButtonLabeled;
      
      public var layout_banner:ClipLayout;
      
      public var tf_input_name:ClipInput;
      
      public var tf_valid_status:ClipLabel;
      
      public var tf_label_banner:ClipLabel;
      
      public var tf_label_max_level:ClipLabel;
      
      public var tf_label_name:ClipLabel;
      
      public var tf_min_level:ClipLabel;
      
      public var cost_panel:ShopCostPanel;
      
      public function ClanCreatePopupClip()
      {
         level_minus = new ClipButton();
         level_plus = new ClipButton();
         button_create = new ClipButtonLabeled();
         button_banner_change = new ClipButtonLabeled();
         layout_banner = ClipLayout.none();
         tf_input_name = new ClipInput();
         tf_valid_status = new ClipLabel();
         tf_label_banner = new ClipLabel();
         tf_label_max_level = new ClipLabel();
         tf_label_name = new ClipLabel();
         tf_min_level = new ClipLabel();
         cost_panel = new ShopCostPanel();
         super();
      }
   }
}
