package game.view.popup.mail
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.AvatarDescClipRenderer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class PlayerMailRendererClip extends GuiClipNestedContainer
   {
       
      
      public var button_read:ClipButtonLabeled;
      
      public var avatar:AvatarDescClipRenderer;
      
      public var tf_date:ClipLabel;
      
      public var tf_from:ClipLabel;
      
      public var tf_subject:ClipLabel;
      
      public var QuestIconFrame_inst0:ClipSprite;
      
      public var portrait:ClipSprite;
      
      public var cutePanel_BG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var layout_title_from:ClipLayout;
      
      public function PlayerMailRendererClip()
      {
         button_read = new ClipButtonLabeled();
         tf_date = new ClipLabel();
         tf_from = new ClipLabel();
         tf_subject = new ClipLabel();
         QuestIconFrame_inst0 = new ClipSprite();
         portrait = new ClipSprite();
         cutePanel_BG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_title_from = ClipLayout.vertical(4,tf_subject,tf_from);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_read.label = Translate.translate("UI_DIALOG_MAIL_READ");
      }
   }
}
