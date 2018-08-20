package game.mechanics.titan_arena.popup
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class TitanArenaPeaceTimeClip extends GuiClipNestedContainer
   {
       
      
      public var button_rules:ClipButtonLabeled;
      
      public var button_shop:ClipButtonLabeled;
      
      public var tf_label_status:ClipLabel;
      
      public var bg1:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public var bg3:GuiClipScale9Image;
      
      public var tf_1:ClipLabel;
      
      public var tf_2:ClipLabel;
      
      public var tf_3:ClipLabel;
      
      public function TitanArenaPeaceTimeClip()
      {
         button_rules = new ClipButtonLabeled();
         button_shop = new ClipButtonLabeled();
         tf_label_status = new ClipLabel();
         bg1 = new GuiClipScale9Image();
         bg2 = new GuiClipScale9Image();
         bg3 = new GuiClipScale9Image();
         tf_1 = new ClipLabel();
         tf_2 = new ClipLabel();
         tf_3 = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_1.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_1");
         tf_2.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_2");
         tf_3.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RULES_GRAPHICS_TEXT_3");
         tf_1.validate();
         tf_2.validate();
         tf_3.validate();
         bg1.graphics.height = Math.max(36,tf_1.height + 20);
         bg2.graphics.height = Math.max(36,tf_2.height + 20);
         bg3.graphics.height = Math.max(36,tf_3.height + 20);
         bg1.graphics.y = bg1.graphics.y - (bg1.graphics.height - 42);
         bg2.graphics.y = bg2.graphics.y - (bg2.graphics.height - 42);
         bg3.graphics.y = bg3.graphics.y - (bg3.graphics.height - 42);
         tf_1.y = bg1.graphics.y + 8;
         tf_2.y = bg2.graphics.y + 8;
         tf_3.y = bg3.graphics.y + 8;
      }
   }
}
