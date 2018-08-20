package game.view.popup.clan
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.shop.ShopCostPanel;
   
   public class ClanEditTitlePopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_create:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_input_name:ClipInput;
      
      public var tf_label_name:ClipLabel;
      
      public var tf_valid_status:ClipLabel;
      
      public var cost_panel:ShopCostPanel;
      
      public var bg:GuiClipScale9Image;
      
      public function ClanEditTitlePopupClip()
      {
         button_create = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_input_name = new ClipInput();
         tf_label_name = new ClipLabel();
         tf_valid_status = new ClipLabel();
         cost_panel = new ShopCostPanel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
