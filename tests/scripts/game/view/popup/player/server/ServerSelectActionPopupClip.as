package game.view.popup.player.server
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class ServerSelectActionPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_new_chr:ClipButtonLabeled;
      
      public var button_transfer:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var tf_new_chr_desc:ClipLabel;
      
      public var tf_new_chr_title:ClipLabel;
      
      public var tf_server_name:ClipLabel;
      
      public var tf_transfer_desc:ClipLabel;
      
      public var tf_transfer_title:ClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var bg1:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public var layout_new_character:ClipLayout;
      
      public var layout_transfer:ClipLayout;
      
      public function ServerSelectActionPopupClip()
      {
         button_new_chr = new ClipButtonLabeled();
         button_transfer = new ClipButtonLabeled();
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         tf_new_chr_desc = new ClipLabel();
         tf_new_chr_title = new ClipLabel();
         tf_server_name = new ClipLabel();
         tf_transfer_desc = new ClipLabel();
         tf_transfer_title = new ClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg1 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg2 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_new_character = ClipLayout.verticalCenter(10,tf_new_chr_title,tf_new_chr_desc,button_new_chr);
         layout_transfer = ClipLayout.verticalCenter(10,tf_transfer_title,tf_transfer_desc,button_transfer);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_new_chr_desc.maxHeight = Infinity;
         tf_transfer_desc.maxHeight = Infinity;
         layout_new_character.height = NaN;
         layout_transfer.height = NaN;
      }
   }
}
