package game.view.popup.arena.log
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.core.PopUpManager;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class ArenaLogEntryPopupClip extends GuiClipNestedContainer
   {
       
      
      private var vo:ArenaLogEntryVOProxy;
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var player_1:ArenaLogEntryPopupTeam;
      
      public var player_2:ArenaLogEntryPopupTeam;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function ArenaLogEntryPopupClip()
      {
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         player_1 = new ArenaLogEntryPopupTeam();
         player_2 = new ArenaLogEntryPopupTeam();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_close.signal_click.add(close);
      }
      
      private function close() : void
      {
         PopUpManager.removePopUp(this.graphics);
      }
   }
}
