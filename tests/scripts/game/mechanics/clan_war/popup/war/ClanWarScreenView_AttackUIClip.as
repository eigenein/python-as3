package game.mechanics.clan_war.popup.war
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class ClanWarScreenView_AttackUIClip extends GuiClipNestedContainer
   {
       
      
      public var button_defend:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      public function ClanWarScreenView_AttackUIClip()
      {
         button_defend = new ClipButtonLabeled();
         tf_header = new ClipLabel();
         super();
      }
   }
}
