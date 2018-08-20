package game.mechanics.clan_war.popup.war
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.clan_war.popup.ClanWarScreenView_VSClip;
   import game.view.gui.components.ClipButton;
   
   public class ClanWarScreenClip extends GuiClipNestedContainer
   {
       
      
      public var attack_ui:ClanWarScreenView_AttackUIClip;
      
      public var defense_ui:ClanWarScreenView_DefenseUIClip;
      
      public var maps:ClanWarMapsClip;
      
      public var button_close:ClipButton;
      
      public var vs_header:ClanWarScreenView_VSClip;
      
      public var sky_anim:GuiAnimation;
      
      public function ClanWarScreenClip()
      {
         maps = new ClanWarMapsClip();
         button_close = new ClipButton();
         sky_anim = new GuiAnimation();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         sky_anim.playbackSpeed = 0.15;
      }
   }
}
