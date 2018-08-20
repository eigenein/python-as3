package game.mechanics.clan_war.popup.war
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   
   public class ClanWarScreenView_DefenseUIClip extends GuiClipNestedContainer
   {
       
      
      public var button_attack:ClipButtonLabeled;
      
      public function ClanWarScreenView_DefenseUIClip()
      {
         button_attack = new ClipButtonLabeled();
         super();
      }
   }
}
