package game.mediator.gui.popup.chat
{
   import engine.core.clipgui.ClipSprite;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLayout;
   
   public class ChatPopupClip extends PopupClipBase
   {
       
      
      public var clanContent:ChatClanContent;
      
      public var serverContent:ChatServerContent;
      
      public var layout_tabs:ClipLayout;
      
      public var content_layout_container:ClipLayout;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public function ChatPopupClip()
      {
         layout_tabs = ClipLayout.vertical(-16);
         content_layout_container = ClipLayout.none();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         super();
      }
   }
}
