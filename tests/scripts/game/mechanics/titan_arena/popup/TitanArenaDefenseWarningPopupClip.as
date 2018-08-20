package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanArenaDefenseWarningPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var button_ok:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public var tf_message:ClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var layout_text:ClipLayout;
      
      public function TitanArenaDefenseWarningPopupClip()
      {
         button_close = new ClipButton();
         button_ok = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         tf_message = new ClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_text = ClipLayout.verticalMiddleCenter(18,tf_message,button_ok);
         super();
      }
   }
}
