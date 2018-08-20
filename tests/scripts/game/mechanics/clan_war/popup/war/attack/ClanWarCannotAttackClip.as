package game.mechanics.clan_war.popup.war.attack
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipLabel;
   
   public class ClanWarCannotAttackClip extends GuiClipNestedContainer
   {
       
      
      public var tf_cannot_attack:ClipLabel;
      
      public var top_bg:GuiClipScale9Image;
      
      public function ClanWarCannotAttackClip()
      {
         tf_cannot_attack = new ClipLabel();
         super();
      }
   }
}
