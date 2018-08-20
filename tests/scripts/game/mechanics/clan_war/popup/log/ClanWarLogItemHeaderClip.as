package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLogItemHeaderClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var size:GuiClipLayoutContainer;
      
      public function ClanWarLogItemHeaderClip()
      {
         tf_label = new ClipLabel();
         size = new GuiClipLayoutContainer();
         super();
      }
   }
}
